class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(u_id: auth['uid'], token: auth['credentials']['token'])

    user.nickname = auth['info']['nickname']
    user.t_id = auth['info']['team_id']

    user.save
    user
  end
end
