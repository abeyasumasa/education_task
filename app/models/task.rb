class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validates :expiration_date, presence: true

  scope :desc_sort, -> {order(created_at: :desc)}
  scope :sort_expired, -> {order(expiration_date: :desc)}
  scope :search_name, -> (name){where('name LIKE ?', "%#{ name }%")}
  scope :search_state, -> (state){where('state LIKE ?', "%#{ state  }%")}
  scope :search_name_and_state, -> (name,state){where('name LIKE ? AND state LIKE ?', "%#{ params[:task][:name] }%","%#{ params[:task][:state] }%")}

    def self.list(parameter)
      if  parameter[:sort_expired] == "true"
        sort_expired
      elsif parameter[:task].present?
        if parameter[:task][:name].present?
          search_name(parameter[:task][:name])
        elsif parameter[:task][:state].present?
          search_state(parameter[:task][:state] )
        else
          search_name_and_state(parameter[:task][:name],parameter[:task][:state])
        end
      else
          desc_sort
      end
  end

end
