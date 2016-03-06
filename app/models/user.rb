class User < ActiveRecord::Base
  validates :u_id, presence: true,
                   uniqueness: true

  belongs_to :team
  has_many :sentiments

  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(u_id: auth['uid'])

    user.nickname = auth['info']['nickname']
    user.team_id = Team.find_or_create_by(slack_id: auth['info']['team_id'], name: auth['info']['team']).id
    user.token = auth['credentials']['token']

    user.save
    user
  end
end
