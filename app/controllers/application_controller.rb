class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid

  private

  def handle_invalid(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
