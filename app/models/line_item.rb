class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity, :total_price

  belongs_to :order
  belongs_to :product

  def self.form_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li
  end
end
