require 'rails_helper'

RSpec.describe Team, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slack_id) }
end
