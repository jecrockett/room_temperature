class Channel < ActiveRecord::Base
  validates :name,     presence: true
  validates :team_id,  presence: true
  validates :slack_id, presence: true,
                       uniqueness: true

  belongs_to :team
  has_many :sentiments, dependent: :destroy

  default_scope { order(:name) }

  after_create :clear_cache
  after_destroy :clear_cache

  def clear_cache
    Rails.cache.clear
  end
end
