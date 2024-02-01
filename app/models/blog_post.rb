class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  before_save :generate_slug

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
