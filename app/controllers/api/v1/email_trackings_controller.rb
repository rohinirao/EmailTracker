class Api::V1::EmailTrackingsController < ActionController::API
  def stats
    @email_trackings = EmailTracking.with_download_hits_count
    render json: @email_trackings, each_serializer: Api::V1::EmailTrackingStatsSerializer
  end

  def create
    message_id = params.dig(:email_tracking, :message_id)
    @email_tracking = EmailTracking.find_or_create_by!(message_id: message_id)
    render json: @email_tracking, serializer: Api::V1::EmailTrackingSerializer, status: :ok
  end
end
