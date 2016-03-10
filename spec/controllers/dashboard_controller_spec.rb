require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  fixtures :users
  describe "GET show" do
    it "assigns variables correctly with no user passed in" do
      user = users(:first)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get :show, {channel: "1",
                     user: "",
                    range: "week"}

      expect(response.status).to eq 200
      expect(assigns[:channel_data].count).to eq 4
      expect(assigns[:user_data]).to eq nil
      expect(assigns[:chart_title]).to eq "Sentiments This Week in turing"
      expect(assigns[:x_axis_labels].count).to eq 2
    end

    it "assigns variables correctly with a user passed in" do
      user = users(:first)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get :show, {channel: "1",
                     user: "1",
                    range: "week"}

      expect(response.status).to eq 200
      expect(assigns[:channel_data].count).to eq 2
      expect(assigns[:user_data].count).to eq 2
      expect(assigns[:chart_title]).to eq "Sentiments This Week in turing -- Highlighting: crockett"
      expect(assigns[:x_axis_labels].count).to eq 2
    end
  end
end
