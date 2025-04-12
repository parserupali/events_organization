# frozen_string_literal: true

class EventOrganizer < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy

  after_destroy :destroy_user

  def destroy_user
    user.destroy
  end
end
