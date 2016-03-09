require 'rails_helper'

RSpec.describe GraphManager, type: :model do
  fixtures :sentiments, :channels, :users

  it "Sets channel data to nil if no channel is passed in" do
    gm = GraphManager.new("", "", "week")
    data = gm.channel_data

    expect(data).to eq nil
  end

  # it "Returns today's channel data when requested" do
  #   gm = GraphManager.new("1", "", "0")
  #   data = gm.channel_data
  #
  #   expect(data.count).to eq 1
  # end

  # it "Returns yesterday's's channel data when requested" do
  #   # can't figure out why this fails!!!
  #   gm = GraphManager.new("1", "", "1")
  #   data = gm.channel_data
  #
  #   expect(data.count).to eq 1
  # end

  it "Returns channel data from 3-days-ago when requested" do
    gm = GraphManager.new("1", "", "3")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

  it "Returns channel data from 4-days-ago when requested" do
    gm = GraphManager.new("1", "", "4")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

  it "Returns weekly channel 1 data when requested" do
    gm = GraphManager.new("1", "", "week")
    data = gm.channel_data

    expect(data.count).to eq 4
  end

  it "Returns weekly channel 2 data when requested" do
    gm = GraphManager.new("2", "", "week")
    data = gm.channel_data

    expect(data.count).to eq 2
  end

  it "returns channel 2 data without the user's data" do
    gm = GraphManager.new("2", "1", "week")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

end
