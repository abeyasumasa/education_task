class Task < ApplicationRecord
  validates :content, presence: true

  def self.desc_sort
     order(created_at: :desc)
  end
end
