require 'rails_helper'

RSpec.describe Api::V1::EmailTrackingsController, type: :request do
  describe 'POST #create' do
    context 'when the EmailTracking exists' do
      let!(:existing_email_tracking) { FactoryBot.create(:email_tracking, message_id: '<123@example.com>') }

      it 'returns the URL of the existing EmailTracking' do
        post api_v1_email_trackings_path, params: { email_tracking: { message_id: '<123@example.com>' } }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(existing_email_tracking.url)
      end
    end

    context 'when the EmailTracking does not exist' do
      it 'creates a new EmailTracking and returns the URL' do
        post api_v1_email_trackings_path, params: { email_tracking: { message_id: "<unique@example.com>" } }, as: :json

        response_data = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(EmailTracking.count).to eq(1)
      end
    end

    context 'when the message_id is missing' do
      it 'returns an error' do
        post api_v1_email_trackings_path, params: { email_tracking: {} }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("error")
      end
    end
  end
end
