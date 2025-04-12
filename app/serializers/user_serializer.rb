# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :email

  def full_name
    object.full_name
  end
end
