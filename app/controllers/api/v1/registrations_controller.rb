module Api
  module V1
    class RegistrationsController <  ApplicationController
      include Devise::Controllers::Helpers

      skip_before_action :authenticate_user!, only: [:create]
      respond_to :json

      def create
        user = User.new(sign_up_params)

        if user.save
          render json: { message: 'User created successfully', user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end
    end
  end 
end