module ErrorHandler
  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error  end

  def not_found_error
    render json: {
      code: 'not_found',
      error: 'Record not found'
    }, status: 404
  end

  def not_found_error
    render json: {
      code: 'not_found',
      error: 'Record not found'
    }, status: 404
  end
end