class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :expiration_date, presence: true

  def self.desc_sort
     order(created_at: :desc)
  end

  def self.sort_expired
     order(expiration_date: :desc)
  end
end
