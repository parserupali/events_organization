module Api
  module V1
    class RegistrationsController <  ApplicationController
      include Devise::Controllers::Helpers
      VALID_ROLES = %w[customer event_organizer].freeze


      skip_before_action :authenticate_user!, only: [:create]
      before_action :validate_role, only: [:create]
      respond_to :json

      def create
        user = User.new(sign_up_params)
        if user.save
          create_role_wise_user(user)

          render json: { message: "#{@role} created successfully", user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private
      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

      def event_organizer_params
        params.require(:event_organizer).permit(:company_name, :phone_number)
      end

      def customer_params
        params.require(:customer).permit(:phone_number)
      end

      def validate_role
        @role = params[:user][:role].presence || 'customer'

        unless VALID_ROLES.include?(@role)
          return render json: { error: "Invalid role: #{@role}" }, status: :unprocessable_entity
        end
      end

      def create_role_wise_user(user)
        user.add_role(@role.to_sym)

        case @role
        when 'event_organizer'
          user.create_event_organizer(event_organizer_params)
        when 'customer'
          user.create_customer(customer_params)
        end
      end
    end
  end 
end