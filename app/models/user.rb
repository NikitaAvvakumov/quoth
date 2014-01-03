class User < ActiveRecord::Base

  validates :name, :email, :username, presence: true
  validates :username, length: { maximum: 15 }, format: { with: /\A[a-z\d_]+\z/i }, uniqueness: true
  validates :email, format: { with: /\A[\w.+\-]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  has_secure_password

  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end
end
