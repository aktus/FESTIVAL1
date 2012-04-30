# We are requiring the omniauth lib
Rails.application.config.middleware.use OmniAuth::Builder do

  # Urls
  # Facebook: https://developers.facebook.com/setup
  # Twitter: https://developer.twitter.com/apps/new

  # When modified (this file), you should restart you server :)


  # List of authorized providers for this app
  
  provider(:facebook,
           ENV['FB_APP_ID'],
           ENV['FB_APP_SECRET'],
           :scope => "email,offline_access,create_event,user_location,user_events,friends_events")

 #provider :twitter,ENV['uyHvDPLgRfGTaQtIfNaZw'],ENV['tLw2KKf8dNvSi3EymeMXkB2snRsXnhShqTrBsP8IXR0']
 provider :twitter, "uyHvDPLgRfGTaQtIfNaZw", "tLw2KKf8dNvSi3EymeMXkB2snRsXnhShqTrBsP8IXR0"

end
