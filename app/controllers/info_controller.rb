class InfoController < ApplicationController
  def who_bought
    @product = Product.find_by_id(params[:id])

    @orders = (@product.present? ? @product.orders : Order.all)

    respond_to do |format|
      format.html
      format.xml {render :layout => false }
    end
  end


  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html
      format.json{ render :json => @order}
    end
  end
end
