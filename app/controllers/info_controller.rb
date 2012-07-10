class InfoController < ApplicationController
  def who_bought
    @product = Product.find_by_id(params[:id])
    @orders = (@product.present? ? @product.orders : Order.all)

    respond_to do |format|
      format.html
      format.xml {render :layout => false }
    end
  end

  def edit
    @orders = Orders.find(params[:id])
  end

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
end
