# frozen_string_literal: true

module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: %i[show update destroy]
      before_action :authorize_event_organizer, only: [:create]

      # GET /events
      def index
        events = Event.all
        authorize events
        render json: events
      end

      # GET /events/1
      def show
        authorize @event
        render json: @event
      end

      # POST /events
      def create
        event = current_user.event_organizer.events.new(event_params)
        authorize event
        if event.save
          render json: event, status: :created, location: api_v1_event_url(event)
        else
          render json: event.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /events/1
      def update
        authorize @event
        if @event.update(event_params)
          SendEventUpdateNotificationJob.perform_async(@event.id)

          render json: @event
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      # DELETE /events/1
      def destroy
        authorize @event
        @event.destroy!
        render json: { message: 'Event deleted successfully.' }, status: :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def event_params
        params.require(:event).permit(:title, :description, :event_date, :venue, :event_organizer_id,
                                      tickets_attributes: %i[id ticket_type price quantity _destroy])
      end

      def authorize_event_organizer
        render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.event_organizer?
      end
    end
  end
end
