require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    login_as(:dave)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => { :hashed_password => "1111", :name => "bb", :salt => "cc"}
    end
    assert_redirected_to :controller => "users"
  end

  test "should show user" do
    get :show, :id => @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user
    assert_response :success
  end

  test "should update user" do
    put :update, :id => "413685242", :user => { :hashed_password => "111", :name => "aa", :salt => "bb" }
    assert_redirected_to :controller =>"users"
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user
    end

    assert_redirected_to users_path
  end
end
