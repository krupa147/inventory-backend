module ErrorHandler
  extend ActiveSupport::Concern
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_error
    rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error
    rescue_from ActionController::ParameterMissing, with: :param_missing_error
  end

  private

  def invalid_error(exception)
    render json: {
      code: 'invalid_record',
      error: 'Invalid Record',
      error_message: exception.record.errors.full_messages
    }, status: 422
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

  def param_missing_error(exception)
    render json: {
      code: 'param_missing',
      error: 'Missing or Invalid parameter',
      param: exception.param
    }, status: 422
  end
end