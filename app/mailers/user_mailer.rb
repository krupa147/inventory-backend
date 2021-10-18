# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.onboard.subject
  #
  def onboard
    @user = params[:user]

    mail to: @user.email, subject: 'Welcome to Inventory System'
  end
end
