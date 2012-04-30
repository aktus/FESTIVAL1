require 'net/http'
require 'uri'

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :is_signed_in?, :current_user_image

  before_filter :load_pages_for_the_links
  #before_filter :load_facebook_token

  protected
#########################################################################################################
  def current_user
    return @current_user if @current_user
    if session[:user_id]
      return @current_user = User.find(session[:user_id])
    end
    if cookies[:remember_me_id] and cookies[:remember_me_hash]
      @current_user = User.find(cookies[:remember_me_id])
      @current_user = nil unless @current_user.remember_me_hash == cookies[:remember_me_hash]
      session[:user_id] = @current_user.id
   end
  rescue
    session[:user_id] = nil
  end
 def require_login
    require_condition(current_user, t('require_login'))
  end
 def require_admin
    require_condition((current_user and current_user.admin), t('require_admin'))
  end
###########################################################################################################
  def is_signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def load_pages_for_the_links
    @pages_for_links = Page.order('position, title ASC').select(['title', 'slug'])
  end

  def load_facebook_token
    @facebook_token = FacebookEvents.get_token
  end
end
