class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, ENV['SECRET_KEY_BASE'])
  end
  
  def self.decode(token)
    return HashWithIndifferentAccess.new(JWT.decode(token, ENV['SECRET_KEY_BASE']))
  rescue
    nil
  end
end