class Task < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
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
  scope :search_tag, -> (tag_id){where(id:Tagging.where(tag_id: tag_id ).select(:task_id))}

    def self.list(parameter)
      if  parameter[:sort_expired] == "true"
        sort_expired
      elsif parameter[:sort_created] == "true"
        desc_sort
      elsif parameter[:task].present?
        if parameter[:task][:name].present?  and parameter[:task][:state].present? and parameter[:task][:tag_id].present?
          search_name(parameter[:task][:name]).search_state(parameter[:task][:state] ).search_tag(parameter[:task][:tag_id])
        elsif parameter[:task][:name].present?  and parameter[:task][:state].present?
          search_name(parameter[:task][:name]).search_state(parameter[:task][:state] )
        elsif parameter[:task][:name].present?  and parameter[:task][:tag_id].present?
          search_name(parameter[:task][:name]).search_tag(parameter[:task][:tag_id])
        elsif search_state(parameter[:task][:state] )  and parameter[:task][:tag_id].present?
          search_state(parameter[:task][:state] ).search_tag(parameter[:task][:tag_id])
        elsif parameter[:task][:state].present?
          search_state(parameter[:task][:state] )
        elsif parameter[:task][:name].present?
          search_name(parameter[:task][:name])
        else
          search_tag(parameter[:task][:tag_id])
        end
      else
          priority
      end
  end

end
