class Channel < ActiveRecord::Base
  belongs_to :team
  has_many :sentiments, dependent: :destroy
end
