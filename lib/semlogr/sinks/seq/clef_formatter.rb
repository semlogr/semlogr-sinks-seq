module Semlogr
  module Sinks
    module Seq
      class ClefFormatter
        def initialize(opts = {})
          default_opts = {
            mode: :custom,
            time_format: :ruby,
            use_to_json: true
          }

          @opts = default_opts.merge(opts)
        end

        def format(log_event)
          event = {
            '@t' => log_event.timestamp.iso8601(3),
            '@l' => log_event.severity.to_s,
            '@mt' => log_event.template.text
          }

          add_error(event, log_event.error)
          add_properties(event, log_event.properties)

          event_json = Oj.dump(event, @opts)
          "#{event_json}\n"
        end

        private

        def add_error(event, error)
          return unless error
          event['@x'] = "#{error.class}: #{error.message}"

          return unless error.backtrace && error.backtrace.any?
          event['@x'] += "\n\s\s#{error.backtrace.join("\n\s\s")}"
        end

        def add_properties(event, properties)
          event.merge!(properties) { |_, old, _| old }
        end
      end
    end
  end
end
