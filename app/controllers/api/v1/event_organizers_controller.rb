module Api
  module V1
    class EventOrganizersController <  ApplicationController
      skip_before_action :authenticate_user!, only: [:create]
      before_action :set_event_organizer, only: %i[ show update destroy ]

      # GET /event_organizers
      def index
        @event_organizers = EventOrganizer.all

        render json: @event_organizers
      end

      # GET /event_organizers/1
      def show
        render json: @event_organizer
      end

      # POST /event_organizers
      def create
        @event_organizer = EventOrganizer.new(event_organizer_params)

        if @event_organizer.save
          render json: @event_organizer, status: :created, location: @event_organizer
        else
          render json: @event_organizer.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /event_organizers/1
      def update
        if @event_organizer.update(event_organizer_params)
          render json: @event_organizer
        else
          render json: @event_organizer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /event_organizers/1
      def destroy
        @event_organizer.destroy!
      end

      private
        def set_event_organizer
          @event_organizer = EventOrganizer.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end

        # Only allow a list of trusted parameters through.
        def event_organizer_params
          params.require(:event_organizer).permit(:company_name, :phone_number)
        end
    end
  end 
end


