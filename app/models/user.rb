class User < Sequel::Model
  include ::Mixins::Authenticatable

  plugin :validation_helpers

  def validate
    super
    validates_unique(:email)
  end
end
