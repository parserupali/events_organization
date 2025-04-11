class EventOrganizerSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :company_name, :phone_number, :created_at, :updated_at

  def full_name
    "#{object.user.first_name} #{object.user.last_name}" if object.user
  end

  def email
    object.user.email if object.user
  end
end