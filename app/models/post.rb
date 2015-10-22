class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_and_belongs_to_many :categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true
  validates :description, presence: true

  before_save :generate_slug!

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def to_param
    self.slug
  end

  def generate_slug!
    slug_base = to_slug(self.title)
    slug_current = slug_base

    post = Post.find_by slug: slug_current
    count = 2

    while post && post != self
      slug_current = slug_base + "-#{count}"
      post = Post.find_by slug: slug_current
      count += 1
    end
    self.slug = slug_current
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.downcase
  end
    
end