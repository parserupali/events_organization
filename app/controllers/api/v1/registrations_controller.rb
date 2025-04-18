# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      include Devise::Controllers::Helpers
      VALID_ROLES = %w[customer event_organizer].freeze

      skip_before_action :authenticate_user!, only: [:create]
      before_action :validate_role, :validate_role_presence, only: [:create]
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

      def validate_role_presence
        return unless params[:user][:role].blank?

        render json: { error: 'Role is required' }, status: :unprocessable_entity
      end

      def validate_role
        @role = params[:user][:role].presence || 'customer'

        return if VALID_ROLES.include?(@role)

        render json: { error: "Invalid role: #{@role}" }, status: :unprocessable_entity
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
