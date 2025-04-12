# frozen_string_literal: true

module Api
  module V1
    class TicketsController < ApplicationController
      before_action :set_ticket, only: %i[show]
      before_action :set_event, only: %i[index show]

      # GET event/:event_id/tickets
      def index
        render json: @event.tickets
      end

      # GET /tickets/1
      def show
        render json: @ticket
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_ticket
        @ticket = Ticket.find(params[:id])
      end

      def set_event
        @event = Event.find(params[:event_id])
      end

      # Only allow a list of trusted parameters through.
      def ticket_params
        params.require(:ticket).permit(:event_id, :ticket_type, :price, :quantity)
      end
    end
  end
end
