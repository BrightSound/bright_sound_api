module BrightSound
  class Authentication < BrightSound::Base
    resource :authentication do

      # curl -X GET localhost:9292/api/authentication/login
      desc 'Login'
      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post :login do
        if user = User.authenticate(params)
          present user, with: BrightSound::Entities::UserEntity
        else
          # TODO: translate
          error!('Unauthorized', 401)
        end
      end

      desc 'Sign Up'
      params do
        requires :email, type: String, desc: 'User email'
        requires :password, type: String, desc: 'User password'
      end
      post :sign_up do
        user = User.new(params)
        begin
          user.save
          present user, with: BrightSound::Entities::UserEntity
        rescue Sequel::ValidationFailed
          error!('Validation error', 401)
        end
      end

    end
  end
end
