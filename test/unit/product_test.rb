require 'test_helper'

class ProductTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

   test "invalid with empty attributes" do
     product = Product.new
     assert product.invalid?
     assert_equal  product.errors[:title], ["不能为空字符"]
     assert_equal  product.errors[:description], ["不能为空字符"]
     assert_equal  product.errors[:price], ["不是数字","should be at least 0.01"]
     assert_equal  product.errors[:image_url], ["不能为空字符","must be a URL for GIF,JPG or PNG image."]
   end

  test "positive price" do
    product = Product.new(:title => "My Book Title", :description => "yyy", :image_url => "zzz.jpg")
    product.price = -1
    assert !product.valid?
    product.price = 0
    assert !product.valid?
    product.price = 1
    assert product.valid?
  end

  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}

    bad = %w{fred.doc fred.gif/more fred.gif.more}

    ok.each do |name|
      product = Product.new(:title => "My Book Title", :description => "yyy", :price => 1, :image_url => name)
      assert product.valid?, product.errors.full_messages
    end

    bad.each do |name|
      product = Product.new(:title => "My Book Title", :description => "yyy", :price => 1, :image_url => name)
      assert !product.valid?, "saving #{name}"
    end
  end

  test "valid unique title" do
      product = Product.new(:title => products(:ruby_book).title, :description => "yyy", :price => 1, :image_url => "fred.gif")
      assert !product.valid?
      assert_equal ["已经被使用"], product.errors[:title]
  end
end
