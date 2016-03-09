require 'rails_helper'

RSpec.describe GraphManager, type: :model do
  fixtures :sentiments, :channels, :users

  it "Sets channel data to nil if no channel is passed in" do
    gm = GraphManager.new("", "", "week")
    data = gm.channel_data

    expect(data).to eq nil
  end

  it "Returns today's channel data when requested" do
    gm = GraphManager.new("1", "", "0")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

  it "Returns weekly channel data when requested" do
    gm = GraphManager.new("1", "", "week")
    data = gm.channel_data

    expect(data.count).to eq 2
  end

  it "Returns channel 1 data when requested" do
    gm = GraphManager.new("1", "", "0")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

  it "Returns channel 2 data when requested" do
    gm = GraphManager.new("2", "", "0")
    data = gm.channel_data

    expect(data.count).to eq 2
  end

  it "returns channel 2 data without the user's data" do
    gm = GraphManager.new("2", "1", "0")
    data = gm.channel_data

    expect(data.count).to eq 1
  end

end
