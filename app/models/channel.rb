class Channel < ActiveRecord::Base
  validates :name,     presence: true
  validates :team_id,  presence: true
  validates :slack_id, presence: true,
                       uniqueness: true

  belongs_to :team
  has_many :sentiments, dependent: :destroy
end
