require_relative 'base'
module BrightSound
  module Endpoints
    class Authentication < Base
      resource :authentication do

        after {
          present current_user,
                        with: BrightSound::Entities::UserEntity if current_user
        }

        # curl -X GET localhost:9292/api/authentication/login
        desc 'Login'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post :login do
          login
        end

        desc 'Sign Up'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post :sign_up do
          login if User.create(params)
        end
      end
    end
  end
end
