# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  attr_reader :current_user

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    return render_missing_token unless token

    handle_token_authentication(token)
  end

  def handle_token_authentication(token)
    decoded_token = decode_token(token)
    return render_revoked_token if token_revoked?(decoded_token)

    @current_user = find_user(decoded_token)
  rescue JWT::ExpiredSignature
    render json: { error: 'Token has expired' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :unauthorized
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256')[0]
  end

  def token_revoked?(decoded_token)
    JwtDenylist.exists?(jti: decoded_token['jti'])
  end

  def find_user(decoded_token)
    User.find(decoded_token['user_id'])
  end

  def render_missing_token
    render json: { error: 'Missing token' }, status: :unauthorized
  end

  def render_revoked_token
    render json: { error: 'Token has been revoked' }, status: :unauthorized
  end

  # Handle the case when a user is not authorized to perform an action
  def user_not_authorized(_exception)
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
