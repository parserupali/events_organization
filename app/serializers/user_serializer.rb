class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :email, :created_at, :updated_at

  def full_name
    object.full_name
  end 
end