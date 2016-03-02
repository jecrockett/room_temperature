require 'rails_helper'

RSpec.describe SlackService do
  fixtures :users, :channels
  describe "#pull_new_messages" do
    it "gets new messages from specified channel" do
      VCR.use_cassette 'new_channel_messages' do
        user = users(:first)
        channel = channels(:first)
        slack = SlackService.new
        response = slack.pull_new_messages(channel, user.token)

        expect(response.first.keys).to include("user", "type", "text", "ts")
      end
    end
  end
end
