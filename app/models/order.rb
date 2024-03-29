class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type

  PAYMENT_TYPES = [
  #Displayed  stored in db
    ["Check", "check"],
  ["Credit card", "cc" ],
  ["Purchase order", "po" ],
  ]

  validates_presence_of :address, :email, :name, :pay_type
  validates_inclusion_of :pay_type, :in => PAYMENT_TYPES.map{|disp,value| value}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  def add_line_items_form_cart(cart)
    cart.items.each do |item|
      li = LineItem.form_cart_item(item)
      line_items << li
    end
  end

  has_many :line_items
  has_many :products, :through => :line_items
end
