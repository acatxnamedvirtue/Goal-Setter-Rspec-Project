class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, :cheers_bank, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :cheers_bank, numericality: { greater_than_or_equal_to: 0 }

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :goals
  include Commentable
  has_many :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)

    @user && @user.is_password?(password) ? @user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def give_cheer(goal)
    if self.cheers_bank > 0
      goal.cheers_value += 1
      goal.save!
      self.cheers_bank -= 1
      self.save!
    end
  end
end
