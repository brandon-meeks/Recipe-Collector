# require_relative '../db/connection'

class User < ActiveRecord::Base
  has_secure_password
  has_many :recipes

  validates :username, uniqueness: true
  validates_presence_of :username, :email, :password_digest

  def self.authenticate(username = '', password = '')
    user = User.find_by(username: user)
    if user && user.password == BCRYPT::ENGINE.hash_secret(password)
      user
    end
  end

  def admin?
    role == 'superuser'
  end

  def standard?
    role == 'standard'
  end
end
