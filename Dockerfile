FROM alpine
MAINTAINER jspc <james@zero-internet.org.uk>

RUN apk add --update --no-cache ruby \
                                ruby-bundler \
                                ruby-libs \
                                ca-certificates

WORKDIR /hobo-poller
ADD . .

RUN bundle install
CMD ruby app.rb
