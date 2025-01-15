# spec/integration/api/v1/download_hits_spec.rb
require 'swagger_helper'

RSpec.describe 'api/v1/download_hits', type: :request do
  path '/api/v1/download_hits' do
    get 'Lists download hits with counts' do
      tags 'DownloadHits'
      produces 'application/json'

      response '200', 'list of download hits' do
        schema type: :array, items: {
          type: :object,
          properties: {
            url: { type: :string },
            download_hits_count: { type: :integer }
          },
          required: [ 'url', 'download_hits_count' ]
        }

        before do
          EmailTracking.create!(message_id: '123abc@gmail.com')
        end

        run_test!
      end
    end
  end

  path '/api/v1/email_trackings/{email_tracking_uuid}/download_hits/track' do
    get 'Tracks download hits and serves an image' do
      tags 'DownloadHits'
      produces 'image/png'

      parameter name: :email_tracking_uuid, in: :path, type: :string, description: 'Email tracking UUID'

      response '200', 'image served and hit recorded' do
        let(:email_tracking) do
          EmailTracking.create!(message_id: '123abc@gmail.com')
        end
        let(:email_tracking_uuid) { email_tracking.uuid }

        run_test!
      end
    end
  end
end
