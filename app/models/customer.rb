class Customer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :tickets, through: :bookings
  has_many :booking_tickets, through: :bookings
  
  after_destroy :destroy_user

  def destroy_user
    user.destroy
  end
  
end
