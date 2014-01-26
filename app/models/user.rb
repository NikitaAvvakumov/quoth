class User < ActiveRecord::Base

  validates :name, :email, :username, presence: true
  validates :username, length: { maximum: 15 }, format: { with: /\A[a-z\d_]+\z/i }, uniqueness: true
  validates :email, format: { with: /\A[\w.+\-]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  before_save :downcase_email
  before_create :create_remember_token

  def downcase_email
    self.email.downcase!
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
