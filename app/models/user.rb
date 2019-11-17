class User < ApplicationRecord
  before_destroy :anotheradmin_check
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  has_secure_password
  scope :admin_count, -> {where(admin: 'true').count}

  private

  def anotheradmin_check
    if User.admin_count == 1 and admin?
      throw :abort
    end
  end
end
