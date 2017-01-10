module Mixins
  module Authenticatable
    include BCrypt

    def self.included(base)
      base.extend(ClassMethods)
    end

    def password
      # Initialize a BCrypt::Password instance from hashed password
      @password ||= Password.new(password_hash)
    end

    # This creates a hashed password from a clear text password
    # The hashed password is then stored in the password_hash member
    # that will be written to the database
    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

    module ClassMethods
      def authenticate(creds)
        # creds Hash should contain email and password keys
        # Let's check we have eveything
        if !creds['email'] or !creds['password']
          return false
        end

        # Ok, get the matching user from the database
        user = self[:email => creds['email']]

        # No user ? Bail out.
        if user.nil?
          return false
        end

        # Real authentication stuff is here
        # This uses the #password method above
        # and Bcrypt::Password#== method for comparison
        if user.password == creds['password']
          return user
        end
      end
    end
  end
end
