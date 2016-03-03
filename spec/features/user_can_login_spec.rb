require 'rails_helper'

RSpec.feature "User login", type: :feature do
  scenario "User successfully logs in" do
    visit root_path
    click_on "Login with Slack"

    expect(current_path).to eq dashboard_path
  end
end
