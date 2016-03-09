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
    where(timestamp: (Time.now-6.days).beginning_of_day..Time.now.end_of_day)
  end

  def self.daily(day)
    binding.pry
    where(timestamp: ((Time.now - day.to_i.days).beginning_of_day..(Time.now - day.to_i.days).end_of_day))
  end

  def clear_cache
    Rails.cache.clear
  end
end
