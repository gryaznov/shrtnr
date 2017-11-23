class Link < ApplicationRecord
  URL_REGEXP = %r{(http|https|www)(:\/\/|\.)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?}

  attr_readonly :shorten

  validates :original, presence: true, format: { with: URL_REGEXP }
  validates :shorten, uniqueness: true, allow_blank: true

  before_validation :set_shorten, on: :create

  def set_shorten
    self.shorten = Link.generate_shorten
  end

  def self.generate_shorten
    loop do
      suggestion = SecureRandom.hex(3)
      break suggestion unless exists?(shorten: suggestion)
    end
  end
end
