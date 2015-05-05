class User < ActiveRecord::Base
	has_many :messages, dependent: :destroy

	attr_accessor :remember_token, :activate_token, :reset_token
	before_save { self.email = email.downcase }
  before_save   :downcase_email
  before_create :create_activation_digest
  	validates :name,  presence: true, length: { maximum: 50 }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
   	has_secure_password 
   	validates :password, length: { minimum: 6 }, allow_blank: true

   	# RETURN HASH DIGEST OF (STRING)
   	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
   		BCrypt::Password.create(string, cost: cost)
   	end 

   	# GENERATE RANDOMIZED TOKEN
   	def User.new_token
   		SecureRandom.urlsafe_base64
   	end

	# REMEMBER USER FOR FUTURE SESSION
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# TRUE IF TOKEN = DIGEST
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# FORGET USER
	def forget
    	update_attribute(:remember_digest, nil)
	end

  # ACTIVATES ACCOUNT
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # SENDS ACTIVATION EMAIL
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # SETS PASSWORD RESET ATTRIBUTES
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # SENDS PW RESET EMAIL
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # TRUE IF PASSWORD RESET IS EXPIRED
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    # DOWNCASE EMAIL
    def downcase_email
      self.email = email.downcase
    end

    # CREATE & ASSIGN ACTIVATION TOKEN
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
  