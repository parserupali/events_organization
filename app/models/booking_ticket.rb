class BookingTicket < ApplicationRecord
  belongs_to :booking
  belongs_to :ticket
  
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
end
