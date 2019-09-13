class Task < ApplicationRecord
  validates :content, presence: true

  def self.desc_sort
    @tasks = self.order(updated_at: :desc)
  end
end
