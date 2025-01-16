require 'rails_helper'

RSpec.describe Api::V1::DownloadHitsController, type: :request do
  describe 'GET #track' do
    let(:email_tracking) { FactoryBot.create(:email_tracking, message_id: '<1234@example.com>') }

    it 'creates a new DownloadHit and returns the tracking pixel' do
      allow(Rails.root).to receive(:join).and_return('public/images/happy_face.png')
      allow(File).to receive(:exist?).and_return(true)

      get track_api_v1_email_tracking_download_hits_path(email_tracking.uuid), headers: { 'User-Agent' => 'RSpec Agent', 'REMOTE_ADDR' => '123.45.67.89' }

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('image/png')

      download_hit = email_tracking.download_hits.last
      expect(download_hit).not_to be_nil
      expect(download_hit.ip_address).to eq(request.remote_ip)
      expect(download_hit.user_agent).to eq(request.user_agent)
    end
  end
end
