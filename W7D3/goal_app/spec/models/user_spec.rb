require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}

  it {should validate_presence_of(:password_digest)}

  it {should validate_length_of(:password).is_at_least(6)}

  describe "uniqueness" do
    before(:each) do
      create(:user)
    end
    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe "check password?" do
    let!(:user) {create(:user)}
    context "with a valid password" do
      it "should return true" do
        expect user.check_password?('password').to_be true
      end
    end

    context "with invalid password" do
      it "should return false" do
        expect user.check_password?('password123').to_be false
      end
    end

  end

	describe 'password encryption' do
		it 'does not save password to the database' do
			create(:funny_user)
			user = User.find_by(username: "jim carey")
			expect(user.password).not_to eq('password')	
		end

		it 'encrypts password' do
			expect(BCrypt::Password).to receive(:create).with('abc123')
			build(:user,password: 'abc123')
		end
		
	end
end
