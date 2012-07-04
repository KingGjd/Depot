class Admin::UsersController < ApplicationController
  before_filter :admin_require, :except => [:change_password, :save_change_password]
  # GET /users
  # GET /users.json
  def index
    @users = User.find(:all, :order =>:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = "User #{@user.name} was successfully created."
        format.html { redirect_to(admin_users_path) }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render new_admin_user_path }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "user #{@user.name} was successfully updated."
        format.html { redirect_to(:action => 'index') }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def change_password
    @user = current_user

    respond_to do |format|
      format.html{}
    end
  end

  def save_change_password
    @user = current_user
    old_password = params[:user].delete :old_password
    new_password = params[:user].delete :password
    password_confirmation = params[:user].delete :password_confirmation
    if User.authenticate(@user.name, old_password)
      if @user.update_attributes(:password => new_password,
                                 :password_confirmation => password_confirmation)
        flash[:notice] = "User #{@user.name}'s password was changed successfully."
        redirect_to :controller => 'store'
      else
        render :change_password
      end
    else
      @user.errors.add(:old_password, "旧密码错误")
      render :change_password
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = nil
    rescue Exception  => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to admin_users_url }
      format.json { head :no_content }
    end
  end
end
