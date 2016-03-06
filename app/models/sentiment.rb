class Sentiment < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  belongs_to :team

  # scope :this_week -> { where("created_at > ?", Time.now-7.days) }
  # scope :today -> { where("created_at > ?", Time.now-1.days) }

  def self.weekly
    where("created_at > ?", Time.now-7.days )
  end

  def self.daily
    where("created_at > ?", Time.now-1.days )
  end
end
