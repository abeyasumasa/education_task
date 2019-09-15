class Task < ApplicationRecord
  validates :content, presence: true

  def self.desc_sort
     order(updated_at: :desc)
  end
end
