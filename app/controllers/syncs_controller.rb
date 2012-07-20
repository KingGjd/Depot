class SyncsController < ApplicationController

  skip_before_filter :authorize

  def sina_new
     client = OauthChina::Sina.new
     new(client)
  end

  def sina_callback
    client = OauthChina::Sina.load(Rails.cache.read(build_oauth_token_key(params[:type], params[:oauth_token])))
    callback(client)
  end

  def douban_new
    client = OauthChina::Douban.new
    new(client)
  end

  def douban_callback
    client = OauthChina::Douban.load(Rails.cache.read(build_oauth_token_key(params[:type], params[:oauth_token])))
    callback(client)
  end

  def new(client)
    authorize_url = client.authorize_url
    Rails.cache.write(build_oauth_token_key(client.name, client.oauth_token), client.dump)
    redirect_to authorize_url
  end

  def callback(client)
    client.authorize(:oauth_verifier => params[:oauth_verifier])
    results = client.dump

    if results[:access_token] && results[:access_token_secret]
      flash[:notice] = "授权成功"
      session[:user_id] = 39 #TODO 用户通过第三方登入后直接注册
    else
      flash[:notice] = "授权失败"
    end
    redirect_to "/access_sina_test"
  end

  private

    def build_oauth_token_key(name, oauth_token)
      [ name, oauth_token ].join("_")
    end
end
