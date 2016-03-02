require 'rails_helper'

RSpec.describe SlackService do
  fixtures :users
  describe "#pull_new_messages" do
    it "gets new messages from specified channel" do
      VCR.use_cassette 'new_channel_messages' do
        user = users(:first)
        slack = SlackService.new
        response = slack.pull_new_messages("C03HS2LS0", user.token)

        expect('2').to eq '2'
       end
     end
  end
end
