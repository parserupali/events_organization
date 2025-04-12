class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :event
  has_many :booking_tickets, dependent: :destroy
  has_many :tickets, through: :booking_tickets

  # Validations
  validates :customer_id, presence: true
  validates :event_id, presence: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: ['pending', 'confirmed', 'canceled'] }
end
