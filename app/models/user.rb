class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :comment_votes, :dependent => :destroy
  has_many :votes, :dependent => :destroy
  validates_confirmation_of :password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_uniqueness_of :username

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email_or_username, password)
    user = find_by_username(email_or_username) || find_by_email(email_or_username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

end