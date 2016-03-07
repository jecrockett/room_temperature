require 'rails_helper'

RSpec.feature "User logout", type: :feature do
  scenario "User successfully logs out" do
    visit root_path
    click_on "Login with Slack"

    expect(current_path).to eq '/dashboard'

    click_on "Logout"

    expect(current_path).to eq root_path

    visit dashboard_path

    expect(current_path).to eq root_path
  end
end
