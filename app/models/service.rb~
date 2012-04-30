class Service < ActiveRecord::Base
  # A service belongs to an User, which can have multiple services.
  belongs_to :user
  validates_presence_of :uid, :provider, :user
  attr_accessible :provider, :uid, :user


  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.create_from_hash!(hash)
    Service.create(:user => user, :provider => hash['provider'])#:uid => hash['uid'],
  end


  def facebook_avatar
    "http://graph.facebook.com/#{uid}/picture?type=square"
  end
  def twitter_avatar
  " http://a1.twimg.com/profile_images/75075164/twitter_bird_profile_bigger.png~~V"
  end
  def facebook_profile
    "https://www.facebook.com/profile.php?id=#{uid}"
  end
 #def twitter_profile
    #"https://twitter.com/#!id=#{uid}" 
  #end
def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.token = auth["credentials"]["token"]
      user.secret = auth["credentials"]["secret"]
    end
  end
  
  def tweet(message)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = self.token
      config.oauth_token_secret = self.secret
    end

    client = Twitter::Client.new
    client.update(message)
  end
end
