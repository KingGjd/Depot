require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    login_as(:dave)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    login_as(:dave)
    assert_difference('Product.count') do
      post :create, :product => { :description => 'desc', :image_url => 'prd.jpg', :title => 'new prd', :price => 20.00 }
    end
    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => @product
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product, :product => { :description => 'new desc', :image_url => 'new_prd.jpg', :title => 'new title', :price => 20.00 }
    assert_redirected_to product_path(assigns(:product))
    @product.reload
    assert_equal 'new desc', @product.description
    assert_equal 'new title', @product.title
    assert_equal 'new_prd.jpg', @product.image_url
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product
    end

    assert_redirected_to products_path
  end
end
