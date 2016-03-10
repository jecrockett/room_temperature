require 'rails_helper'

RSpec.feature "User deletes a channel", type: :feature do
  scenario "User clicks on delete for a channel being tracked" do
    visit root_path
    click_on "Login with Slack"

    visit channels_path

    visit new_channel_path
    select '1406', from: 'channel-select'
    click_on "T R A C K"

    within ".tracked-channels" do
      expect(page).to have_content "1406"
    end

    click_on "Delete"

    expect(current_path).to eq channels_path
    within ".flash-container" do
      expect(page).to have_content "You've deleted 1406 and all of its sentiments."
    end

    visit channels_path

    within ".tracked-channels" do
      expect(page).to_not have_content "1406"
    end
  end

end
