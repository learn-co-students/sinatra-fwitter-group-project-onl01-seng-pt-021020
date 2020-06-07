class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :password, presence: true
  validates :username, :email, uniqueness: true, presence: true

  def slug
    self.username.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|obj|obj.slug == slug}
  end
end
