class EventOrganizerSerializer < ActiveModel::Serializer
  attributes :id, :company_name, :phone_number, :created_at, :updated_at

  belongs_to :user, serializer: UserSerializer
end