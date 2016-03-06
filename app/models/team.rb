class Team < ActiveRecord::Base
  validates :name,     presence: true
  validates :slack_id, presence: true

  has_many :channels
  has_many :sentiments
  has_many :users
end
