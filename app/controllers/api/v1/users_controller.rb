# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :validate_role_presence, only: [:create]
      before_action :set_user, only: %i[show update destroy]

      # GET /users
      def index
        users = User.all
        authorize users
        render json: users
      end

      # GET /users/1
      def show
        authorize @user
        render json: @user
      end

      # POST /users
      def create
        user = User.new(user_params)
        authorize user
        if user.save
          setup_user_profile(user)
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        authorize @user
        @user.update(user_params)
        render json: @user
      end

      # DELETE /users/1
      def destroy
        authorize @user
        @user.destroy
        render json: { message: 'User deleted successfully' }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

      def validate_role_presence
        return unless params[:user][:role].blank?

        render json: { error: 'Role is required' }, status: :unprocessable_entity
      end

      def setup_user_profile(user)
        user.add_role(params[:user][:role]) if params[:user][:role].present?
        create_role_specific_profile(user)
      end

      def create_role_specific_profile(user)
        case params[:user][:role]
        when 'event_organizer'
          user.create_event_organizer(event_organizer_params)
        when 'customer'
          user.create_customer(customer_params)
        end
      end

      def event_organizer_params
        params.require(:event_organizer).permit(:company_name, :phone_number)
      end

      def customer_params
        params.require(:customer).permit(:phone_number)
      end
    end
  end
end
