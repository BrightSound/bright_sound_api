class User < Sequel::Model
  include ::Mixins::Authenticatable
  MIN_PASSWORD_LENGTH = 8
  MAX_PASSWORD_LENGTH = 64

  plugin :validation_helpers

  def validate
    super
    validates_unique(:email)
    validates_min_length(MIN_PASSWORD_LENGTH, :password)
    validates_max_length(MAX_PASSWORD_LENGTH, :password)
    errors.add(:password, 'is too popular, not safe') if PasswordValidator.in_common?(password)
  end

end
