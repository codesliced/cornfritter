class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    user = Twitter.user(self.screen_name)
    last_ten = Twitter.user_timeline(user.screen_name, :count =>10)
    last_ten.each { |tweet| self.tweets << Tweet.create(:text => tweet.text) }
    self.touch
  end

  def tweets_stale?
    minutes = (Time.now - self.updated_at)/60
    return false if minutes < 15
    return true if minutes >= 15
  end

end
