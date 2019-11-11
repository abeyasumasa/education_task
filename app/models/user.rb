class User < ApplicationRecord
  before_destroy :anotheradmin_check
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  has_secure_password

  private

  def anotheradmin_check
    throw(:abort) if User.where(admin: true).count <= 2 && self.admin?
  end
end
