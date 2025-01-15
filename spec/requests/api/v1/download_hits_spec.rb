require 'rails_helper'

RSpec.describe Api::V1::DownloadHitsController, type: :request do
  describe 'GET #index' do
    before do
      email_tracking1 = FactoryBot.create(:email_tracking, message_id: '<1234@example.com>', url: "http://localhost:3000/api/v1/email_trackings/uuid1/download_hits/track")
      email_tracking2 = FactoryBot.create(:email_tracking, message_id: '<12345@example.com>', url: "http://localhost:3000/api/v1/email_trackings/uuid2/download_hits/track")

      FactoryBot.create_list(:download_hit, 3, email_tracking: email_tracking1)
      FactoryBot.create_list(:download_hit, 2, email_tracking: email_tracking2)
    end

    it 'returns a list of email trackings with download hits count' do
      get api_v1_download_hits_path

      expect(response).to have_http_status(:ok)

      response_data = JSON.parse(response.body)

      expect(response_data).to contain_exactly(
        {
          'url' => 'http://localhost:3000/api/v1/email_trackings/uuid1/download_hits/track',
          'download_hits_count' => 3
        },
        {
          'url' => 'http://localhost:3000/api/v1/email_trackings/uuid2/download_hits/track',
          'download_hits_count' => 2
        }
      )
    end
  end

  describe 'GET #track' do
  let(:email_tracking) { FactoryBot.create(:email_tracking, message_id: '<1234@example.com>') }

  it 'creates a new DownloadHit and returns the tracking pixel' do
    allow(Rails.root).to receive(:join).and_return('public/images/hpy.png')
    allow(File).to receive(:exist?).and_return(true)

    puts track_api_v1_email_tracking_download_hits_path(email_tracking_uuid: email_tracking.uuid)

    # get "/api/v1/email_trackings/#{email_tracking.uuid}/download_hits/track"
    # get "/api/v1/email_trackings/1/download_hits/track"

    get track_api_v1_email_tracking_download_hits_path(email_tracking.uuid), headers: { 'User-Agent' => 'RSpec Agent', 'REMOTE_ADDR' => '123.45.67.89' }

    expect(response).to have_http_status(:ok)
    expect(response.content_type).to eq('image/png')

    download_hit = email_tracking.download_hits.last
    expect(download_hit).not_to be_nil
    expect(download_hit.ip_address).to eq(request.remote_ip)
    expect(download_hit.user_agent).to eq(request.user_agent)
  end
end


  # describe 'GET #track' do
  #   let(:email_tracking) { FactoryBot.create(:email_tracking, message_id: '<1234@example.com>') }

  #   it 'creates a new DownloadHit and returns the tracking pixel' do
  #     allow(Rails.root).to receive(:join).and_return('path_to_your_image/tracking_pixel.png')
  #     allow(File).to receive(:exist?).and_return(true)

  #     get :track, params: { uuid: email_tracking.uuid }

  #     expect(response).to have_http_status(:ok)
  #     expect(response.content_type).to eq('image/png')

  #     download_hit = email_tracking.download_hits.last
  #     expect(download_hit).not_to be_nil
  #     expect(download_hit.ip_address).to eq(request.remote_ip)
  #     expect(download_hit.user_agent).to eq(request.user_agent)
  #   end

  #   it 'returns a tracking pixel even if EmailTracking is not found' do
  #     allow(Rails.root).to receive(:join).and_return('path_to_your_image/tracking_pixel.png')
  #     allow(File).to receive(:exist?).and_return(true)

  #     get :track, params: { uuid: 'non_existent_uuid' }

  #     expect(response).to have_http_status(:ok)
  #     expect(response.content_type).to eq('image/png')
  #     expect(DownloadHit.count).to eq(0)
  #   end
  # end
end
