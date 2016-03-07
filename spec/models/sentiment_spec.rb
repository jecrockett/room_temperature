require 'rails_helper'

RSpec.describe Sentiment, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:team_id) }
  it { should validate_presence_of(:channel_id) }
  it { should validate_presence_of(:slack_id) }
end
