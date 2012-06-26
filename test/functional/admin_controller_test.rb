require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get login" do
    dave = users(:dave)
    post :login, :name => dave.name, :password => 'secret'
    assert_redirected_to admin_index_path
    assert_equal dave.id, session[:user_id]
  #  assert_response :success
  end

  test "should get lonout" do
    get :lonout
  end

  test "should get index" do
    get :index, {}, { :user_id => users(:dave).id }
    assert_response :success
    assert_template "index"
  end

  test "bad password" do
    dave = users(:dave)
    post :login, :name => dave.name, :password => 'asdfasdfwrong'
    assert_response :success
    assert_template "login"
  end
end
