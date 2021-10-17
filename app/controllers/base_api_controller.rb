class BaseApiController < ApplicationController
  include Authenticator

  before_action :authenticate_request
end