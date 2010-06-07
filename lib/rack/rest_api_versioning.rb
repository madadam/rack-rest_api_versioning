require 'rack'

module Rack
  class RestApiVersioning
    def initialize(app)
      @app = app
    end

    def call(env)
      extract_version!(env)
      @app.call(env)
    end

    PATTERN = /.*\-v(\d+)/

    private

    def extract_version!(env)
      version = env['HTTP_ACCEPT'].to_s[PATTERN, 1]
      env['rack.rest_api_version'] = version
    end
  end
end
