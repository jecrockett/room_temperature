class Sentiment < ActiveRecord::Base
  validates :user_id,    presence: true
  validates :team_id,    presence: true
  validates :channel_id, presence: true
  validates :slack_id,   presence: true

  belongs_to :user
  belongs_to :channel
  belongs_to :team

  after_create :clear_cache
  after_destroy :clear_cache

  def self.weekly
    where("created_at > ?", Time.now-7.days )
  end

  def self.daily
    where("created_at > ?", Time.now-1.days )
  end

  def clear_cache
    Rails.cache.clear
  end
end
