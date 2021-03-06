class Task < ApplicationRecord
  belongs_to :user
  paginates_per 5
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :expiration_date, presence: true
  validates :state, presence: true

  scope :desc_sort, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expiration_date: :desc)}
  scope :priority, -> {order(priority: :desc)}
  scope :search_name, -> (name){where('name LIKE ?', "%#{ name }%")}
  scope :search_state, -> (state){where('state LIKE ?', "%#{ state  }%")}
  scope :search_name_and_state, -> (name,state){search_name(name).search_state(state)}

    def self.list(parameter)
      if  parameter[:sort_expired] == "true"
        sort_expired
      elsif parameter[:sort_created] == "true"
        desc_sort
      elsif parameter[:task].present?
        if parameter[:task][:name].present?  and parameter[:task][:state].present?
          search_name_and_state(parameter[:task][:name],parameter[:task][:state])
        elsif parameter[:task][:state].present?
          search_state(parameter[:task][:state] )
        else
          search_name(parameter[:task][:name])
        end
      else
          priority
      end
  end

end
