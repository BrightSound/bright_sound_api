require_relative 'base'
module BrightSound
  module Endpoints
    class Authentication < Base
      resource :authentication do

        after {
          present current_user,
                        with: BrightSound::Entities::UserEntity if current_user
        }

        # curl -X POST localhost:9292/api/authentication/login -F email=user@example.com -F 'password=asdf123!'
        desc 'Login'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post :login do
          login
        end

        # curl -X POST localhost:9292/api/authentication/sign_up -F email=user@example.com -F 'password=asdf123!'
        desc 'Sign Up'
        params do
          requires :email, type: String, desc: 'User email'
          requires :password, type: String, desc: 'User password'
        end
        post :sign_up do
          login if User.create(params)
        end

        # curl -X POST localhost:9292/api/authentication/logout
        desc 'Logout'
        post :logout do
          logout
        end
      end
    end
  end
end
