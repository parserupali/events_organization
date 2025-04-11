module Api
  module V1
    class SessionsController <  ApplicationController
      include Devise::Controllers::Helpers

      skip_before_action :authenticate_user!, only: [:create]

      def create
        user = User.find_by(email: params[:user][:email])

        if user&.valid_password?(params[:user][:password])
          token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i, jti: SecureRandom.uuid }, Rails.application.credentials.devise_jwt_secret_key)
          render json: { token: token, user: { id: user.id, email: user.email } }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        token = request.headers['Authorization']&.split(' ')&.last
        if token
          decoded_token = JWT.decode(token,  Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')[0]
          JwtDenylist.create!(jti: decoded_token['jti'], exp: Time.at(decoded_token['exp']))
        end

        render json: { message: 'Logged out successfully' }, status: :ok
      end

      private
      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end

