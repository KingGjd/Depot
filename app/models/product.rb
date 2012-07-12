class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :title, :price, :file, :avatar
  has_many :orders, :through => :line_items
  has_many :line_items

  validates_presence_of :title , :description, :image_url
  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :title
  validates_format_of :image_url, :with => %r{\.(gif|jpg|png)$}i, :message => lambda { I18n.t('models.product.image') }

  attr_accessor :file
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  before_validation :save_image

  protected
    def price_must_be_at_least_a_cent
      errors.add(:price, I18n.t('models.product.price')) if price.nil?|| price < 0.01
    end
    def self.find_products_for_sale
      find(:all, :order => "title")
    end

  private

    def save_image
      return if self.file.nil?

      img_dir = File.join(Rails.root, 'app/assets/images')
      img_url = File.join("uploads", Time.now.to_i.to_s)
      img_extname = File.extname(self.file.original_filename)
      img_full_path = File.join(img_dir, img_url + img_extname)
      File.open(img_full_path, 'wb') { |f| f.write self.file.read }
      self.image_url = (img_url + img_extname)
    end
end
