class Customer < ApplicationRecord
  belongs_to :user
  
  after_destroy :destroy_user

  def destroy_user
    user.destroy
  end
  
end
