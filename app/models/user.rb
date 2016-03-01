class User < ActiveRecord::Base
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(u_id: auth['uid'], token: auth['credentials']['token'])

    user.nickname = auth['info']['nickname']

    user.save
    user
  end
end
