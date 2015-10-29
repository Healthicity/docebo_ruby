require 'test_helper'

class DoceboRuby::ApiTest < Minitest::Unit::TestCase

  def test_internal_server_error_case
    params = { userid: 'sample@example.com',
               first_name: 'big',
               last_name: 'binary' }

    response = mock()
    response.expects(:code).returns(500)
    RestClient.stubs(:post).yields(response)

    assert_raises DoceboRuby::RequestError do
      DoceboRuby::API.new.send_request('user', 'create', params)
    end
  end
end
