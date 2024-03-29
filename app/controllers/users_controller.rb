class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
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
    name = params[:user].delete :name
    password =params[:user].delete :password
    confirm =params[:user].delete :confirm
    @user = User.new(:name => name, :password =>password, :password_confirmation => confirm )
    respond_to do |format|
      if @user.save
        flash[:notice] = "#{@user.name} #{I18n.t('controllers.users.create')}"
        format.html { redirect_to admin_login_path }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
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
        flash[:notice] = "#{@user.name} #{I18n.t('controllers.users.change')}"
        redirect_to :controller => 'store'
      else
        render :change_password
      end
    else
      @user.errors.add(:old_password, "错误")
      render :change_password
    end
  end

end
