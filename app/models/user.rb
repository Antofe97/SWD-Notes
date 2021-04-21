class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :notes
  
  def is_normal_user?
    self.permission_level >=1
  end

  def is_admin?
    self.permission_level >=2
  end
  
end
