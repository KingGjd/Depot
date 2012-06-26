class ApplicationController < ActionController::Base
  layout "home"

  protect_from_forgery

  before_filter :authorize, :except => :login
  before_filter :set_locale
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  protected

    def set_locale
      session[:locale] = params[:locale] if params[:locale]
      I18n.locale = session[:locale] || I18n.default_locale

      locale_path = File.join(LOCALES_DIRECTORY, "#{I18n.locale}.yml")

      if I18n.load_path.exclude? locale_path
        I18n.load_path << locale_path
        I18n.backend.send(:init_translations)
      end
    rescue Exception => err
      logger.err err.inspect
      flash[:notice] = "#{I18n.locale} translation not available"

      I18n.load_path -= [locale_path]
      I18n.locale = session[:locale] = I18n.default_locale
    end

    def authorize
      unless User.find_by_id(session[:user_id])
        flash[:notice] = "Please log in"
        redirect_to :controller => 'admin', :action => 'login'
      end
    end

    def admin_require
      raise '你没有权限访问此页面。' unless current_user.admin?
    end
end
