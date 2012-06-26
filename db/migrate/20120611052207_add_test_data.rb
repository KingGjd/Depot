class AddTestData < ActiveRecord::Migration
  def up
    Product.delete_all
    Product.create(:title => 'Pragmatic Version Control' ,
                   :description =>%{<p>This book is a recipe_based approach to using</p>}, :image_url => '~/images/svn.jpg' , :price => 28.50)
    Product.create(:title => 'Pragmatic Project Automation ' ,
                :description =>%{<p>This book is a recipe_based approach to using</p>}, :image_url => '~/images/auto.jpg' , :price => 28.50)
  end

  def down
    Product.delete_all
  end
end


