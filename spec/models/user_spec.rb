require 'spec_helper'

describe User, type: :model do
  include Rack::Test::Methods

  describe 'Validation' do
    it{ is_expected.to validate_unique :email }
    it{ is_expected.to validate_min_length 8, :password }
    it{ is_expected.to validate_max_length 64, :password }

    context 'of password in common' do
      let(:user) { build(:user, password: '123456789') }
      it 'should fail if password is in common list' do
        user.validate
        expect(user.valid?).to be_falsy
        expect(user.errors[:password]).to include('is too popular, not safe')
      end
    end
  end

end

