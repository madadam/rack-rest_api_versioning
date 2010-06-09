require 'rack'

module Rack
  class RestApiVersioning
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      extract_version!(env)
      @app.call(env)
    end

    # 1
    # 1.2
    # 1.2.3
    VERSION_STRING       = '(\d+(?:\.\d+)*)'

    # application/vnd.foo.bar-v1+xml
    # application/vnd.foo.bar-v1.2.3+json
    # ...
    HTTP_ACCEPT_PATTERN  = /.*\-v#{VERSION_STRING}/

    # ?version=1.2.3
    QUERY_STRING_PATTERN = /\bversion=#{VERSION_STRING}/

    private

    def extract_version!(env)
      version = env['QUERY_STRING'].to_s[QUERY_STRING_PATTERN, 1] ||
                env['HTTP_ACCEPT'].to_s[HTTP_ACCEPT_PATTERN, 1]   ||
                @options[:default_version]

      env['api_version'] = version
    end
  end

  module RequestExtensions
    def api_version
      @env['api_version']
    end
  end
end

Rack::Request.send(:include, Rack::RequestExtensions)
