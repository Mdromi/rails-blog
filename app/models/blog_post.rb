class BlogPost < ApplicationRecord
  after_initialize :set_default_values
  before_save :generate_slug
  validates :title, presence: true
  validates :body, presence: true

  scope :sorted, -> {order(published_at: :desc, updated_at: :desc)}
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft
    published_at.nil?
  end

  def published
    published_at? && published_at <= Time.current
  end

  def scheduled
    published_at? && published_at > Time.current
  end


  private

  def generate_slug
    self.slug = title.parameterize
  end
  def set_default_values
    self.published_at ||= nil
  end
end



