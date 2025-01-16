class Api::V1::DownloadHitsController < ActionController::API
  def track
    email_tracking = EmailTracking.find_by(uuid: params[:email_tracking_uuid])
    if email_tracking
      email_tracking.download_hits.create(user_agent: request.user_agent, ip_address: request.remote_ip)
    end

    send_file Rails.root.join("public/images", "happy_face.png"), type: "image/png", disposition: "inline"
  end
end
