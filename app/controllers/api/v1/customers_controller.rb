module Api
  module V1
    class CustomersController <  ApplicationController
      before_action :set_customer, only: %i[ show update destroy ]
      before_action :reject_role, only: [:update]

      # GET /customers
      def index
        customers = Customer.all
        authorize customers

        render json: customers
      end

      # GET /customers/1
      def show
        authorize @customer
        render json: @customer
      end

      def update
        authorize @customer
        updated_user = @customer.user.update(user_params)
        updated_eo = @customer.update(customer_params)

        if updated_user && updated_eo
          render json: @customer
        else
          render json: {errors: "#{@customer.errors.full_messages} #{@customer.user.errors.full_messages}"}, status: :unprocessable_entity
        end
      end


      # DELETE /customers/1
      def destroy
        authorize @customer
        @customer.destroy!
        render json: { message: 'Customer deleted successfully.' }, status: :ok
      end

      private
        def set_customer
          @customer = Customer.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:first_name, :last_name, :email)
        end

        def customer_params
          params.require(:customer).permit(:phone_number)
        end 

        def reject_role
          params[:user].delete(:role) if params[:user].present? && params[:user][:role].present?
        end
    end
  end
end
