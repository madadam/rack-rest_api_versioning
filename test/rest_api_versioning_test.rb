require File.dirname(__FILE__) + '/test_helper'

class RestApiVersioningTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    @app
  end

  def test_extracts_version_from_content_type
    app! { use Rack::RestApiVersioning }

    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v1+json'
    assert_equal '1', last_request.env['api_version']

    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v2+json'
    assert_equal '2', last_request.env['api_version']
    
    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v1.2.3+json'
    assert_equal '1.2.3', last_request.env['api_version']
  end

  def test_fallbacks_to_default_version_if_no_version_can_be_extracted
    app! { use Rack::RestApiVersioning, :default_version => '4.5' }

    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme+json'
    assert_equal '4.5', last_request.env['api_version']
    
    get '/', {}, 'HTTP_ACCEPT' => 'application/json'
    assert_equal '4.5', last_request.env['api_version']
  end

  def test_does_not_fallback_to_default_version_if_version_can_be_extracted
    app! { use Rack::RestApiVersioning, :default_version => '6.7' }

    get '/', {}, 'HTTP_ACCEPT' => 'application/vnd.acme-v2+json'
    assert_equal '2', last_request.env['api_version']
  end

  def test_allows_version_to_be_overriden_with_query_string_parameter
    app! { use Rack::RestApiVersioning }

    get '/', 'version' => '1.2'
    assert_equal '1.2', last_request.env['api_version']
  end
  
  def test_version_in_query_string_takes_precedence_over_version_in_content_type
    app! { use Rack::RestApiVersioning }

    get '/', 'version' => '1.2', 'HTTP_ACCEPT' => 'application/vnd.acme-v1.3'
    assert_equal '1.2', last_request.env['api_version']
  end

  private

  def app!(&block)
    @app = Rack::Builder.new do
      instance_eval(&block)
      run lambda { |env| [200, {}, []] }
    end.to_app
  end
end

