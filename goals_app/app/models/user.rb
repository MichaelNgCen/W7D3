class User < ApplicationRecord

        validates  :username, :session_token, uniqueness: true
        validates :password, length: { minimum: 6, allow_nil: true }
        validates :username,
                  :password_digest,
                  :session_token,
                  presence: true
      
        attr_reader :password
      
        after_initialize :ensure_session_token

        has_many :notes
      
        def self.find_by_credentials(username, password)
          user = User.find_by(username: username)
      
          user && user.is_password?(password) ? user : nil
        end
      

      
        def password=(password)
          @password = password
          self.password_digest = BCrypt::Password.create(password)
        end
      
        def is_password?(password)
          BCrypt::Password.new(self.password_digest).is_password?(password)
        end
      
        def reset_session_token!
          self.session_token = generate_unique_session_token
          self.save!
      
          self.session_token
        end
      
        def ensure_session_token
          self.session_token ||= generate_unique_session_token
        end
      
        def generate_unique_session_token
          token = SecureRandom.urlsafe_base64(16)
        end
end
