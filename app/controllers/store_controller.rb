class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    #@products = Product.find_products_for_sale

    @products = Product.paginate :page => params[:page], :per_page => 5
    @cart = find_cart
  end

  def add_to_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.add_product(product)

    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error(" #{I18n.t('controllers.store.add_to_cart_error')} #{params[:id]}")
    redirect_to_index(I18n.t('contorllers.store.add_to_cart_index'))
  end

  def reduce_from_cart
    product = Product.find(params[:id])
    @cart = find_cart
    @current_item = @cart.reduce_product(product)

    respond_to do |format|
      format.js if request.xhr?
      format.html {redirect_to_index}
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("#{I18n.t('controllers.store.add_to_cart_error')}#{params[:id]}")
    redirect_to_index(I18n.t('controllers.store.add_to_cart_index'))
  end

  def save_order
    @cart = find_cart
    @order = Order.new params[:order]
    @order.add_line_items_form_cart(@cart)

    if @order.save
      session[:cart] = nil
      redirect_to_index(I18n.t('controllers.store.save_order_index'))
    else
      render :action => 'checkout'
    end
  end

  def empty_cart
    session[:cart] = nil
    redirect_to_index  
  end

  def checkout
    @cart = find_cart

    if @cart.items.empty?
      redirect_to_index(I18n.t('controllers.chechout_index'))
    else
      @order = Order.new
    end
  end

  private

  def redirect_to_index(msg =nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'index'
  end

  def find_cart
    unless session[:cart]
      session[:cart] = Cart.new
    end
    session[:cart]
  end
end
