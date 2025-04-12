class ApplicationController < ActionController::API
  before_action :authenticate_user!
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def current_user
    @current_user
  end

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: "HS256")[0]
        user_id = decoded_token["user_id"]
        jti = decoded_token["jti"]

        if JwtDenylist.exists?(jti: jti)
          return render json: { error: "Token has been revoked" }, status: :unauthorized
        end

        @current_user = User.find(user_id)
      rescue JWT::ExpiredSignature
        render json: { error: "Token has expired" }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { error: "Invalid token" }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :unauthorized
      end
    else
      render json: { error: "Missing token" }, status: :unauthorized
    end
  end

  # Handle the case when a user is not authorized to perform an action
  def user_not_authorized(exception)
    render json: { error: "You are not authorized to perform this action" }, status: :forbidden
  end
end
