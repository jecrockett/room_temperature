require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:u_id) }
  it { should validate_uniqueness_of(:u_id) }
end
