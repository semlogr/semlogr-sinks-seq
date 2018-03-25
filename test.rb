require 'bundler/setup'

Bundler.require

require 'semlogr'
require 'semlogr/sinks/seq'

Semlogr.logger = Semlogr.create_logger do |c|
  c.log_at :info

  c.write_to :seq
end

Semlogr.info('Customer {customer_id} did something interesting', customer_id: 1234)
