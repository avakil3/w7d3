class User < ApplicationRecord
	before_validation :ensure_session_token
	validates :password_digest, presence:true
	validates :password, length: {minimum: 6, allow_nil:true}
	validates :session_token, :username,:email, presence:true, uniqueness:true
	
	def self.find_by_credentials(username, password)
		user = User.find_by(username: username)
		if user && user.check_password?(password)
			user
		else
			nil
		end
	end

	def check_password?(password)
		password_object = BCrypt::Password.new(self.password_digest)
		password_object.is_password?(password)
	end

	def password=(password)
		self.password_digest= BCrypt::Password.create(password)
		@password = password
	end

	def password
		@password
	end

	def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64 
    end 

    def reset_session_token! ## we call this method every time we log a user in or out
        self.session_token = SecureRandom::urlsafe_base64(16)
        self.save! ## used to error out loudly 
        self.session_token  ## we return the session_token so that we can use it in our login! method
    end 


end
