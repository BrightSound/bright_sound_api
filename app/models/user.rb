class User < Sequel::Model
  include ::Mixins::Authenticatable

  plugin :validation_helpers

  def validate
    super
    validates_unique(:email)
  end

  def jwt
    JsonWebToken.encode(jwt_payload)
  end

  private

    def jwt_payload
      { user_id: id }
    end

end
