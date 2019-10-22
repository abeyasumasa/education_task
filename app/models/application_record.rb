class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  enum priority: { 低: 0, 中: 1, 高: 2}
end
