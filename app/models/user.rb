class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_one :event_organizer,  dependent: :destroy
  has_one :customer,  dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  rolify

  def customer?
    has_role?(:customer)
  end

  def event_organizer?
    has_role?(:event_organizer)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
