class ApplicationController < ActionController::API
  include ErrorHandler
  include Paginator
end
