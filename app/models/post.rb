class Post < ActiveRecord::Base
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_and_belongs_to_many :categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true
  validates :description, presence: true
end