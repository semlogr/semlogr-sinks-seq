require 'timeout'
require 'stud/buffer'
require 'semlogr/sinks/seq/clef_formatter'
require 'semlogr/sinks/seq/seq_api'

module Semlogr
  module Sinks
    module Seq
      class Sink
        include Stud::Buffer

        def initialize(opts = {})
          opts = default_options.merge(opts)

          @formatter = ClefFormatter.new(opts)
          @client = create_client(opts)

          exit_handler_initialize(opts)
          buffer_initialize(opts)
        end

        def emit(log_event)
          buffer_receive(log_event)
        end

        def flush(log_events, _group = nil)
          payload = ''

          log_events.each do |log_event|
            payload << @formatter.format(log_event)
          end

          @client.post_events(payload)
        end

        private

        def default_options
          {
            flush_at_exit: true
          }
        end

        def exit_handler_initialize(opts)
          return unless opts[:flush_at_exit]

          at_exit do
            Timeout.timeout(60) { buffer_flush(final: true) }
          end
        end

        def create_client(opts)
          server_url = opts.fetch(:server_url, 'http://localhost:5341')
          api_key = opts.fetch(:api_key, nil)

          SeqApi.new(server_url, api_key)
        end
      end
    end
  end
end
