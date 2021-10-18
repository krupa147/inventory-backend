module ErrorHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
  end

  def not_found_error
    render json: {
      code: 'not_found',
      error: 'Record not found'
    }, status: 404
  end

  def not_authorized_error
    render json: {
      code: 'not_authorized',
      error: 'You are not authorized to perform this action'
    }, status: 403
  end
end