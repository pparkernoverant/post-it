class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts

  validates :name, presence: true, uniqueness: true

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    slug_base = to_slug(self.name)
    slug_current = slug_base

    category = Category.find_by slug: slug_current
    count = 2

    while category && category != self
      slug_current = slug_base + "-#{count}"
      category = Category.find_by slug: slug_current
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
