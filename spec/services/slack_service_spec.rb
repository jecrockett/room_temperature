require 'rails_helper'

RSpec.describe SlackService do
  fixtures :users, :channels
  describe "#pull_new_channels" do
    it "gets new messages from specified channel" do
      VCR.use_cassette 'new_channel_messages' do
        user = users(:other_team)
        channel = channels(:other_team)
        slack = SlackService.new
        response = slack.pull_new_channels(channel, user.token)

        expect(response.first.keys).to include("user", "type", "text", "ts")
      end
    end
  end

  describe "#fetch_team_channels" do
    it "fetches channnels from the current user's team" do
      VCR.use_cassette 'fetch_team_channels' do
        user = users(:first)
        slack = SlackService.new
        response = slack.fetch_team_channels(user)

        expect(response.first.keys).to include("id", "name", "is_channel", "created", "creator", "is_archived", "is_general", "is_member", "members", "topic", "purpose", "num_members")
      end
    end
  end
end
