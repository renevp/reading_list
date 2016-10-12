class Book < ApplicationRecord
  scope :finished, -> { where.not(finished_on: nil)  }
  scope :recent, -> { where('finished_on > ?', 2.days.ago) }
  scope :search, ->(keyword) { where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present?  }

  before_save :set_keywords

  def finished?
    finished_on.present?
  end

  def set_keywords
    self.keywords = [title, author, description].map(&:downcase).join(' ')
  end
end
