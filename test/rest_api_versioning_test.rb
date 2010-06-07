require 'test/unit'
require 'rack'
require 'rack/test'

require 'rack/rest_api_versioning'

class RestApiVersioningTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      use Rack::RestApiVersioning
      run lambda { |env| [200, {}, []] }
    end.to_app
  end

  def test_extracts_version_from_content_type
    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v1+json'
    assert_equal '1', last_request.env['rack.rest_api_version']

    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v2+json'
    assert_equal '2', last_request.env['rack.rest_api_version']
  end
end

