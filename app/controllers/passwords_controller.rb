# frozen_string_literal: true

class PasswordsController < ApplicationController
  def reset
    raise ActionController::ParameterMissing, :token if params[:token].blank?
    raise ActionController::ParameterMissing, :new_password if params[:new_password].blank?

    user = User.find_by(reset_password_token: params[:token])

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:new_password])
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: ['Link not valid or expired. Try generating a new link.'] }, status: :not_found
    end
  end

  def forgot
    raise ActionController::ParameterMissing, :email if params[:email].blank?

    @user = User.find_by(email: params[:email])
    @user.generate_password_token!
    UserMailer.with(user: @user).onboard.deliver_later
    render json: { status: 'ok' }, status: :ok
  end
end
