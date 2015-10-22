class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    slug_base = to_slug(self.username)
    slug_current = slug_base

    user = User.find_by slug: slug_current
    count = 2

    while user && user != self
      slug_current = slug_base + "-#{count}"
      user = User.find_by slug: slug_current
      count += 1
    end
    slug_current
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end
end