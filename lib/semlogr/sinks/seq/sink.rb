require 'semlogr/sinks/seq/clef_formatter'
require 'semlogr/sinks/seq/seq_api'
require 'semlogr/sinks/batching'
require 'semlogr/self_logger'

module Semlogr
  module Sinks
    module Seq
      class Sink < Semlogr::Sinks::Batching
        def initialize(client: nil, formatter: nil, **opts)
          @client = client || create_client(opts)
          @formatter = formatter || ClefFormatter.new

          super(opts)
        end

        def emit_batch(log_events)
          payload = ''

          log_events.each do |log_event|
            payload << @formatter.format(log_event)
          end

          @client.post_events(payload)
        end

        private

        def create_client(opts)
          server_url = opts.fetch(:server_url, 'http://localhost:5341')
          api_key = opts.fetch(:api_key, nil)

          SeqApi.new(server_url, api_key)
        end
      end
    end
  end
end
