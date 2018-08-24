require 'faraday'

module Semlogr
  module Sinks
    module Seq
      class SeqApi
        def initialize(server_url, api_key)
          @server_url = server_url
          @api_key = api_key
        end

        def post_events(payload)
          connection = ::Faraday.new(url: @server_url) do |c|
            c.request   :retry
            c.response  :raise_error
            c.adapter   :net_http
          end

          connection.post('/api/events/raw') do |req|
            req.headers['Content-Type'] = 'application/vnd.serilog.clef'
            req.headers['X-Api-Key'] = @api_key if @api_key

            req.body = payload
          end
        end
      end
    end
  end
end
