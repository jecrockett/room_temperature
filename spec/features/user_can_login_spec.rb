require 'rails_helper'

RSpec.feature "User login", type: :feature do
  scenario "User successfully logs in" do
    visit root_path
    click_on "Login with Slack"

    expect(current_path).to eq dashboard_path
    # how do i do this?
    # slack makes me authorize every time
    # omniauth mock auth
    #hicharts = might play well with what i'm doing. possibly a gem.
  end
end
