class Admin::ProductsController < ApplicationController
  before_filter :admin_require

  # GET /products
  # GET /products.json
  def index
    #@products = Product.all
    @products = Product.paginate :page => params[:page], :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_product_path(@product), :notice => I18n.t('controllers.admin.product.create') }
        format.json { render :json => [:admin,@product], :status => :created, :location =>[:admin, @product] }
      else
        format.html { render new_admin_product_path }
        format.json { render :json => [:admin,@product.errors], :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to admin_product_path(@product), :notice => I18n.t('controllers.admin.product.update') }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admin_products_url}
      format.json { head :no_content }
    end
  end
end
