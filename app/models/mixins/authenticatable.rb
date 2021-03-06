module Mixins
  module Authenticatable
    include BCrypt

    attr_reader :password

    def self.included(base)
      base.extend(ClassMethods)
    end

    def password=(new_password)
      self.password_hash = Password.create(new_password)
      @password = new_password
    end

    module ClassMethods
      def authenticate(creds)
        if !creds['email'] or !creds['password']
          return
        end

        user = self[:email => creds['email']]

        if user.nil?
          return
        end

        if ::BCrypt::Password.new(user.password_hash) == creds['password']
          return user
        else
          return
        end
      end
    end
  end
end
