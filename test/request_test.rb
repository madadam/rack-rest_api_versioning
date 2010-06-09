require File.dirname(__FILE__) + '/test_helper'

class RequestTest < Test::Unit::TestCase
  def test_api_version
    request = Rack::Request.new('api_version' => '1.2.3')
    assert_equal '1.2.3', request.api_version
  end

  def test_api_version_is_nil_if_not_present
    request = Rack::Request.new({})
    assert_nil request.api_version
  end
end
