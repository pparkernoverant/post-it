class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_and_belongs_to_many :categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true
  validates :description, presence: true

  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end