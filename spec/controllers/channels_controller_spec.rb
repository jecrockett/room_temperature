require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
  fixtures :users, :teams
  describe "GET index" do
    it "assigns @tracked_channels" do
      user = users(:first)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get :index

      expect(response.status).to eq 200
      expect(assigns[:tracked_channels].count).to eq 3
    end
  end

  describe "GET new" do
    it "assigns @untracked_channels" do
      user = users(:first)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get :new

      expect(response.status).to eq 200
      expect(assigns[:untracked_channels].first.first).to eq "1406"
    end
  end
end
