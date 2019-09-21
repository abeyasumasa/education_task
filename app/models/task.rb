class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 100 }

  def self.desc_sort
     order(created_at: :desc)
  end
end
