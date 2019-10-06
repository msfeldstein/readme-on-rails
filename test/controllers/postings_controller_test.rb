require 'test_helper'

class PostingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get postings_index_url
    assert_response :success
  end

  test "should get show" do
    get postings_show_url
    assert_response :success
  end

end
