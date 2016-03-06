class Sentiment < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  belongs_to :team

  def self.weekly
    where("created_at > ?", Time.now-7.days )
  end

  def self.daily
    where("created_at > ?", Time.now-1.days )
  end
end
