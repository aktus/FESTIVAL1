class SessionsController < ApplicationController

 skip_authorization_check
##########################################################################################"
  def auth
    session[:return_to] = params[:return_to]
    session[:remember_me] = params[:remember_me]
    redirect_to "/auth/#{params[:provider]}"
  end
  def handle_unverified_request 
    true 
  end 
########################################################################################
  def create
    redirect_url = session[:redirect_url]
    session[:redirect_url] = nil
    auth = request.env['omniauth.auth']
    session[:fb_token] = auth['credentials']['token']
    session[:tw_token] = auth['credentials']['token']
    logger.info(auth['uid'])
    logger.info(auth['provider'])
    logger.info(auth['twitter'])

    unless @auth = Service.find_from_hash(auth)
     @auth = Service.create_from_hash(auth, current_user)
 end 
   
    self.current_user = @auth.user
    #session[:user_image] = auth['user_info']['image']
    redirect_to redirect_url || root_path

    flash[:notice] = t('login.success')
end

  def destroy
    flash[:notice] = t('logout.success')
    session[:user_id] = nil
    session[:fb_token] = nil
    session[:tw_token] = nil
    redirect_to root_path
  end

  # NOTE: Gambiarra!!!
  # Para saber para onde voltar quando
  # for feito o login com o facebook.
  # Se alguém souber melhor, sinta-se à vontade.
  def connect_with_facebook
    session[:redirect_url] = params[:redirect_url]
    redirect_to '/auth/facebook'
  end
def connect_with_twitter
    session[:redirect_url] = params[:redirect_url]
    redirect_to '/auth/twitter'
  end
end
