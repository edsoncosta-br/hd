class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def name_display
    if self.nick_name.empty?
      Methods.name_capitalize(self.name, true)
    else
      Methods.name_capitalize(self.nick_name, false)
    end
  end

  validates :email, presence: true, length: {maximum: 60}
  validates :name, presence: true, length: {maximum: 60}
  validates :company_id, presence: true

  validate :email_isempty
  validate :name_isempty  

  belongs_to :position, required: false
  belongs_to :company

  has_many :allocations

  def active_for_authentication?
    super && active
  end  

  private

  def email_isempty
    if self.email.blank?
      errors.add(:_, '_email_isempty_')
    end
  end
  
  def name_isempty
    if self.name.blank?
      errors.add(:_, '_name_isempty_')
    end
  end
  
  def position_isempty
    if self.position_id.blank?
      errors.add(:_, '_position_isempty_')
    end
  end  
  
end
