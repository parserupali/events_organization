class Ticket < ApplicationRecord
  belongs_to :event
  has_many :booking_tickets, dependent: :destroy
  has_many :bookings, through: :booking_tickets

  # Validations
  validates :ticket_type, presence: true, uniqueness: { scope: :event_id, message: "has already been taken for this event" }, inclusion: { in: ['General Admission', 'VIP', 'Early Bird', 'Group'] }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_update :prevent_changes_if_booked
  before_destroy :prevent_destroy_if_booked

  private

  def prevent_changes_if_booked
    if bookings.exists? && (will_save_change_to_price? || will_save_change_to_quantity?)
      errors.add(:base, "Cannot update ticket once it's been booked")
      throw(:abort)
    end
  end

  def prevent_destroy_if_booked
    if bookings.exists?
      errors.add(:base, "Cannot delete ticket with bookings")
      throw(:abort)
    end
  end
end
