class AddPriceToProduct < ActiveRecord::Migration
  def up
    add_column :products, :price, :decimal, :precision => 8, :scale => 2, :default => 0
  end

  def down
    remove_column :products, :price
  end
end
