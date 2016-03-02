class Sentiment < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
end
