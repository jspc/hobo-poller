#!/usr/bin/env ruby

require 'bunny'
require 'json'
require 'octokit'
require 'redis'

class Poller
  def initialize(repo, key, rabbit_uri, redis_uri)
    @repo = repo
    @client = Octokit::Client.new(:access_token => key)
    @rabbit = Bunny.new(rabbit_uri)
    @storage = Redis.new(url: redis_uri)
  end

  def loop
    @rabbit.start

    channel = @rabbit.create_channel
    queue = channel.queue("pr_builder")

    while true
      @client.pulls(@repo).each do |pr|
        repo = pr[:head][:repo]
        pr_key = "#{@repo}-#{pr[:id]}"

        pushed_date = repo[:pushed_at].to_s

        if @storage.get(pr_key) != pushed_date
          puts "Pushing pr change for #{@repo}}"
          queue.publish({repo: @repo, sha: pr[:head][:sha]}.to_json)

          @storage.set pr_key, pushed_date
        end
      end

      sleep 5
    end

  end
end

repo       = ENV.fetch('REPO')
github_key = ENV.fetch('GITHUB_KEY')
rabbit_uri = ENV.fetch('RABBIT_URI', 'amqp://guest:guest@localhost:5672/')
redis_uri  = ENV.fetch('REDIS_URI', 'redis://localhost:6379/0')

p = Poller.new(repo, github_key, rabbit_uri, redis_uri)

p.loop
