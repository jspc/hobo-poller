hobo-poller
==

`hobo-poller` is a simple app/ container which monitors a specific github repo for changes and, should it find a change, puts a message onto a rabbitmq queue for a `hobo-manager` node to pick up and build.

The tool queries the github API, for a given repo, and looks for open pull requests. It iterates over these open pull requests looking for the last pushed timestap. Should the last pushed timestamp differ to that stored in redis it pushes to a rabbitmq queue.

It requires a couple of env vars at boot:

| var       | purpose | default |
|-----------|------|-----|
| `$REPO` | github repo to keep an eye on   | n/a |
| `$GITHUB_KEY`  | key with which to poll github's api   | n/a |
| `$RABBIT_URI` | location of rabbitmq | `rabbit://guest:guest@localhost:5672` |
| `$REDIS_URI` | location of redis | `redis://localhost:6379/0` |



deets
--

| who       | what |
|-----------|------|
| dockerhub | https://hub.docker.com/r/jspc/hobo-poller/   |
| circleci  | https://circleci.com/gh/jspc/hobo-poller   |
| licence   | MIT   |


Licence
--

MIT License

Copyright (c) 2017 jspc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
