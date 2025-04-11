class Event < ApplicationRecord
  belongs_to :event_organizer 
   
  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :event_date, presence: true
  validates :venue, presence: true
  validates :event_organizer_id, presence: true
end
