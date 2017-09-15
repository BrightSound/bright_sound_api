require 'spec_helper'

describe User, type: :model do
  include Rack::Test::Methods

    it{ is_expected.to validate_unique :email }
    it{ is_expected.to validate_min_length 8, :password }
    it{ is_expected.to validate_max_length 64, :password }

end

