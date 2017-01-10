module BrightSound
  module Entities
    class UserEntity < Grape::Entity
      expose :id
      expose :email
    end
  end
end
