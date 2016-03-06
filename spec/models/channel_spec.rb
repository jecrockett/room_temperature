require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:team_id) }
  it { should validate_presence_of(:slack_id) }
end
