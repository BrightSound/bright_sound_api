module BrightSound
  module Entities
    class UserEntity < Grape::Entity
      expose :email
      expose :access_token do |user, _|
        user.jwt
      end
    end
  end
end
