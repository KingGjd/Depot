class AdminController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        if current_user.admin?
           redirect_to(uri || admin_products_path)
        else
           redirect_to(uri || root_path)
        end
      else
          flash.now[:notice] =I18n.t('controllers.admin.login')
      end
    end
  end

  def lonout
    session[:user_id] =nil
    flash[:notice] = I18n.t('controllers.admin.logout')
    redirect_to(:action  => "login")
  end

  def index
    @total_orders = Order.count
  end
end
