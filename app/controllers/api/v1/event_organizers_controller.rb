# frozen_string_literal: true

module Api
  module V1
    class EventOrganizersController < ApplicationController
      before_action :set_event_organizer, only: %i[show update destroy]
      before_action :reject_role, only: [:update]

      # GET /event_organizers
      def index
        event_organizers = EventOrganizer.all
        authorize event_organizers

        render json: event_organizers
      end

      # GET /event_organizers/1
      def show
        authorize @event_organizer
        render json: @event_organizer
      end

      def update
        authorize @event_organizer
        updated_user = @event_organizer.user.update(user_params)
        updated_eo = @event_organizer.update(event_organizer_params)

        if updated_user && updated_eo
          render json: @event_organizer
        else
          render json: { errors: (@event_organizer.errors + @event_organizer.user.errors).to_s },
                 status: :unprocessable_entity
        end
      end

      # DELETE /event_organizers/1
      def destroy
        authorize @event_organizer
        @event_organizer.destroy!
        render json: { message: 'Event organizer deleted successfully.' }, status: :ok
      end

      private

      def set_event_organizer
        @event_organizer = EventOrganizer.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email)
      end

      def event_organizer_params
        params.require(:event_organizer).permit(:company_name, :phone_number)
      end

      def reject_role
        params[:user].delete(:role) if params[:user].present? && params[:user][:role].present?
      end
    end
  end
end
