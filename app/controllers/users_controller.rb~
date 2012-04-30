class UsersController < InheritedResources::Base
  respond_to :json, :html
############################
def tweet
    if !current_user
      redirect_to root_url, :notice => "Please log in first."
    else
      message = params['message']
      if message.length > 0
       current_user.tweet(message)
        redirect_to root_url, :notice => "I tweeted that." 
      else
        redirect_to root_url, :notice => "Uh, put some text there."
      end
    end
  end  
###################################################
def update_notification
    return unless current_user
    current_user.update_attribute(:notifications_read_at, Time.now)
    return render nothing: true
  end
end
