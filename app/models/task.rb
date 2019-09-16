class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
