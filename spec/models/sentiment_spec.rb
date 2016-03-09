require 'rails_helper'

RSpec.describe Sentiment, type: :model do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:team_id) }
  it { should validate_presence_of(:channel_id) }
  it { should validate_presence_of(:slack_id) }

  it ".weekly returns all Sentiments from that week" do
    expect(Sentiment.weekly.count).to eq 6
  end

  it ".daily returns all Sentiments from specified day" do
    expect(Sentiment.daily("0").count).to eq 2
    expect(Sentiment.daily("1").count).to eq 1
    expect(Sentiment.daily("2").count).to eq 0
    expect(Sentiment.daily("3").count).to eq 1
    expect(Sentiment.daily("4").count).to eq 2
    expect(Sentiment.daily("5").count).to eq 0
  end
end
