# frozen_string_literal: true

# app/serializers/customer_serializer.rb
class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :phone_number

  def full_name
    "#{object.user.first_name} #{object.user.last_name}" if object.user
  end

  def email
    object.user&.email
  end
end
