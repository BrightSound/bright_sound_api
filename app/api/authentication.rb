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
        login
        present current_user, with: BrightSound::Entities::UserEntity
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
