class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :bookings, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :booking_tickets, through: :bookings
  # Validations
  validates :title, presence: true, uniqueness: { scope: :event_date, message: 'should be unique per date' }
  validates :description, presence: true
  validates :event_date, presence: true
  validates :venue, presence: true
  validates :event_organizer_id, presence: true

  accepts_nested_attributes_for :tickets, allow_destroy: true
end
