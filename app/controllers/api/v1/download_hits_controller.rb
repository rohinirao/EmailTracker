class Api::V1::DownloadHitsController < ActionController::API
  def index
    email_trackings = EmailTracking.with_download_hits_count
    response_data = email_trackings.map do |email_tracking|
      {
        url: email_tracking.url,
        download_hits_count: email_tracking.download_hits_count
      }
    end
    render json: response_data, status: :ok
  end

  def track
    uuid = params[:email_tracking_uuid]
    email_tracking = EmailTracking.find_by(uuid: uuid)
    email_tracking.download_hits.create(user_agent: request.user_agent, ip_address: request.remote_ip) if email_tracking

    send_file Rails.root.join("public/images", "hpy.png"),
                type: "image/png",
                disposition: "inline"
  end
end
