# frozen_string_literal: true

class EventOrganizerSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :phone_number

  belongs_to :user, serializer: UserSerializer
end
