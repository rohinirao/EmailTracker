class Api::V1::EmailTrackingsController < ActionController::API
  def create
    message_id = params.dig(:email_tracking, :message_id)
    email_tracking = EmailTracking.find_or_create_by!(message_id: message_id)
    render json: { url: email_tracking.url }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
