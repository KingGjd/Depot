class InfoController < ApplicationController
  def who_bought
    @product = Product.find_by_id(params[:id])
    @orders = (@product.present? ? @product.orders : Order.all)

    respond_to do |format|
      format.html
      format.xml {render :layout => false }
    end
  end
  #TODT 修改
  def edit
    @orders = Orders.find(params[:id])
  end
#TODO 修改
  def update
    @orders = Orders.find(params[:id])

    respond_to do |format|
      if @orders.update_attributes(params[:orders])
        format.html{}
      else
        format.html{}
      end
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
