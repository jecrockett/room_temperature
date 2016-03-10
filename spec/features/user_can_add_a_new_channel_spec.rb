require 'rails_helper'

RSpec.feature "User can add a new channel", type: :feature do
  scenario "User successfully adds a new channel" do
    visit root_path
    click_on "Login with Slack"

    visit new_channel_path
    select '1406', from: 'channel-select'
    click_on "T R A C K"

    expect(current_path).to eq channels_path
    within '.flash-container' do
      expect(page).to have_content("We'll start gathering data for 1406.")
      expect(page).to have_content("Please Note: You will not see data for 1406 appear right away.")
    end
  end

  scenario "User submit the request without selecting a channel" do
    visit root_path
    click_on "Login with Slack"

    visit new_channel_path
    click_on "T R A C K"

    within '.flash-container' do
      expect(page).to have_content("Something went wrong. Try your selection again.")
    end
  end

end
