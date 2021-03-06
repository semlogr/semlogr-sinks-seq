![Codeship Status for semlogr/semlogr-sinks-seq](https://codeship.com/projects/f9d58b10-15c6-0136-e7ad-1a0f3e5cdd95/status?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/fffee3ba60898aa5f437/maintainability)](https://codeclimate.com/github/semlogr/semlogr-sinks-seq/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fffee3ba60898aa5f437/test_coverage)](https://codeclimate.com/github/semlogr/semlogr-sinks-seq/test_coverage)

# Seq sink for Semlogr

This sink provides support for writing logs to [seq](https://getseq.net/), the sink uses [ruby-stud](https://github.com/jordansissel/ruby-stud) to provide batch flushing of events using the Seq HTTP API.

## Installation

To install:

    gem install semlogr-sinks-seq

Or if using bundler, add semlogr to your Gemfile:

    gem 'semlogr-sinks-seq'

then:

    bundle install

## Getting Started

Create an instance of the logger configuring the seq sink with your token.

```ruby
require 'semlogr'
require 'semlogr/sinks/seq'

Semlogr.logger = Semlogr.create_logger do |c|
  c.log_at :info

  c.write_to :seq, server_url: 'http://seq', api_key: '1234'
end

Semlogr.info('Customer {customer_id} did something interesting', customer_id: 1234)
```

## Development

After cloning the repository run `bundle install` to get up and running, to run the specs just run `rake spec`.

## Contributing

See anything broken or something you would like to improve? feel free to submit an issue or better yet a pull request!
