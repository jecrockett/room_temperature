require 'rails_helper'

RSpec.describe GraphManager, type: :model do
  fixtures :sentiments, :channels, :users

  before :all do
    Rails.cache.clear
  end

  describe "#channel_data" do
    context "No channel is passed in" do
      it "Sets channel data to nil" do
        gm = GraphManager.new("", "", "week")
        data = gm.channel_data

        expect(data).to eq nil
      end
    end

    context "A channel and range is passed in, but no user" do
      it "Returns today's channel data" do
        gm = GraphManager.new("1", "", "0")
        data = gm.channel_data

        expect(data.count).to eq 1
      end

      it "Returns yesterday's's channel data" do
        gm = GraphManager.new("1", "", "1")
        data = gm.channel_data

        expect(data.count).to eq 1
      end

      it "Returns channel data from 3-days-ago" do
        gm = GraphManager.new("1", "", "3")
        data = gm.channel_data

        expect(data.count).to eq 1
      end

      it "Returns channel data from 4-days-ago" do
        gm = GraphManager.new("1", "", "4")
        data = gm.channel_data

        expect(data.count).to eq 1
      end

      it "Returns weekly channel 1 data" do
        gm = GraphManager.new("1", "", "week")
        data = gm.channel_data

        expect(data.count).to eq 4
      end

      it "Returns weekly channel 2 data" do
        gm = GraphManager.new("2", "", "week")
        data = gm.channel_data

        expect(data.count).to eq 2
      end
    end

    context "A user is specified in addition to a channel and range" do
      it "returns partial channel 2 data without the user's data" do
        gm = GraphManager.new("2", "1", "week")
        data = gm.channel_data

        expect(data.count).to eq 1
      end
    end
  end

  describe "#user_data" do
    it "returns the specified user's data separately" do
      gm = GraphManager.new("2", "1", "week")
      data = gm.user_data

      expect(data.count).to eq 1
    end
  end

  describe "#complete_channel_data" do
    it "returns entire dataset for specified channel" do
      gm = GraphManager.new("1", "", "week")
      data = gm.complete_channel_data

      expect(data.count).to eq 4
    end
  end

  describe "#partial_channel_data" do
    it "returns entire dataset for that channel minus the user's data" do
      gm = GraphManager.new("1", "2", "week")
      data = gm.partial_channel_data

      expect(data.count).to eq 2
    end
  end

  describe "#chart_range" do
    it "determines weekly range" do
      gm = GraphManager.new("1", "", "week")
      range = gm.chart_range

      expect(range).to eq "This Week"
    end

    it "determines 'today' range" do
      gm = GraphManager.new("1", "", "0")
      range = gm.chart_range

      expect(range).to eq "Today"
    end

    it "determines 'yesterday' range" do
      gm = GraphManager.new("1", "", "1")
      range = gm.chart_range

      expect(range).to eq "Yesterday"
    end

    it "determines 'x-days-ago' range" do
      gm = GraphManager.new("1", "", "2")
      range = gm.chart_range

      expect(range).to eq "2 Days Ago"

      gm = GraphManager.new("1", "", "4")
      range = gm.chart_range

      expect(range).to eq "4 Days Ago"
    end
  end

  describe "#chart_title" do
    context "No channel is selected" do
      it "instructs user to select a channel" do
        gm = GraphManager.new("", "", "week")
        title = gm.chart_title

        expect(title).to eq "Please select a channel from the dropdown menu."
      end
    end

    context "Channel is specified, but no user" do
      it "sets title for 'week' request" do
        gm = GraphManager.new("1", "", "week")
        title = gm.chart_title

        expect(title).to eq "Sentiments This Week in turing"
      end

      it "set title for 'today' request" do
        gm = GraphManager.new("1", "", "0")
        title = gm.chart_title

        expect(title).to eq "Sentiments Today in turing"
      end

      it "sets title for '3-days-ago' request" do
        gm = GraphManager.new("1", "", "3")
        title = gm.chart_title

        expect(title).to eq "Sentiments 3 Days Ago in turing"
      end
    end

    context "a channel, range, and user are all specified" do
      it "mentions the specified user in the title" do
        gm = GraphManager.new("1", "2", "week")
        title = gm.chart_title

        expect(title).to eq "Sentiments This Week in turing -- Highlighting: tmoore"
      end
    end
  end

  describe "#find_endpoints" do
    it "returns min and max when only channel data is sent in" do
      gm = GraphManager.new("1", "", "week")
      channel_data = gm.channel_data
      user_data = nil
      endpoints = gm.find_endpoints(channel_data, user_data)

      earliest = endpoints.first[0..4]
      latest = endpoints.last[0..4]

      expect(earliest).to eq (Time.now - 4.days).strftime('%m-%d')
      expect(latest).to eq (Time.now).strftime('%m-%d')
    end

    it "returns min and max of combined data set when both channel and user data are sent in" do
      gm = GraphManager.new("1", "1", "week")
      channel_data = gm.channel_data
      user_data = gm.user_data
      endpoints = gm.find_endpoints(channel_data, user_data)

      earliest = endpoints.first[0..4]
      latest = endpoints.last[0..4]

      expect(earliest).to eq (Time.now - 4.days).strftime('%m-%d')
      expect(latest).to eq (Time.now).strftime('%m-%d')
    end
  end
end
