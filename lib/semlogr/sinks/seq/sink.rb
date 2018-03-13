require 'stud/buffer'
require 'semlogr/formatters/json_formatter'
require 'semlogr/sinks/seq/seq_api'

module Semlogr
  module Sinks
    module Seq
      class Sink
        include Stud::Buffer

        def initialize(opts = {})
          @options = opts
          @formatter = Formatters::JsonFormatter.new
          @client = create_client(opts)

          buffer_initialize(opts)
        end

        def emit(log_event)
          buffer_receive(log_event)
        end

        def flush(log_events, _group = nil)
          payload = ''

          log_events.each do |log_event|
            payload << @formatter.format(log_event) do |event|
              seq_event = event[:properties] || {}
              seq_event = seq_event.merge(
                '@t' => event[:timestamp],
                '@l' => event[:severity],
                '@mt' => event[:message_template]
              )

              add_error(seq_event, event[:error])

              seq_event
            end
          end

          @client.post_events(payload)
        end

        private

        def create_client(opts)
          server_url = opts.fetch(:server_url, 'http://localhost:5341')
          api_key = opts.fetch(:api_key, nil)

          SeqApi.new(server_url, api_key)
        end

        def add_error(seq_event, error)
          return unless error
          seq_event['@x'] = "#{error[:type]}: #{error[:message]}"

          return unless error[:backtrace] && error[:backtrace].any?
          seq_event['@x'] += "\n\s\s#{error[:backtrace].join("\n\s\s")}"
        end
      end
    end
  end
end
