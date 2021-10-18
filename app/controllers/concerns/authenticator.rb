module Authenticator
  extend ActiveSupport::Concern

  attr_accessor :current_user

  def authenticate_request
    @current_user = current_loggedin_user
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def http_token
    token = request.headers['Authorization'].split(" ")[1]
    token
  end

  def decoded_token
    JsonWebToken.decode(http_token)
  end

  def current_loggedin_user
    raise JWT::DecodeError if decoded_token.nil?
    User.find_by!(email: decoded_token[:email])
  end
end