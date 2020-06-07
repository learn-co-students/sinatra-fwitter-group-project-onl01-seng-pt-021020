class User < ActiveRecord::Base
  has_secure_password
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  has_many :tweets

  def slug
    self.username.gsub(' ', '-')
  end
  def self.find_by_slug(slug)
    self.all.detect{|user|user.slug == slug}
  end
end