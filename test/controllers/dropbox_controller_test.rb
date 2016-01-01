require 'test_helper'

class DropboxControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

  test "should get isAuthenticated" do
    get :isAuthenticated
    assert_response :success
  end

end
