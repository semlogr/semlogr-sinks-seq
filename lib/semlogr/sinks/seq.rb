require 'semlogr/sinks/seq/version'
require 'semlogr/sinks/seq/sink'
require 'semlogr/component_registry'

module Semlogr
  module Sinks
    module Seq
      def self.new(opts = {})
        Sink.new(**opts)
      end
    end

    ComponentRegistry.register(:sink, seq: Seq)
  end
end
