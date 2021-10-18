class AuthorizedBaseApiController < ApplicationController
  include Authenticator
  include Pundit

  before_action :authenticate_request
end