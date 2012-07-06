class InfoController < ApplicationController
  def who_bought
    @product = Product.find_by_id(params[:id])
    @orders = (@product.present? ? @product.orders : Order.all)

    respond_to do |format|
      format.html
      format.xml {render :layout => false }
    end
  end
end
