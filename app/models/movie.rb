class Movie < ApplicationRecord
  before_validation :set_slug

  has_many :reviews, dependent: :destroy
  has_and_belongs_to_many :genres
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\Z/i,
    message: 'must reference a GIF, JPG, or PNG image'
  }

  RATINGS = %w[G PG PG-13 R NC-17]

  scope :released, -> { where('released_on <= ?', Time.now).order('released_on desc') }
  scope :upcoming, -> { where('released_on > ?', Time.now).order('released_on asc') }
  scope :recent, ->(max = 5) { released.limit(max) }

  def flop?
    nil if reviews.count > 50 && average_stars >= 4
    total_gross.blank? || total_gross < 225_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
