require 'swagger_helper'

RSpec.describe 'API::V1::EmailTrackings', type: :request do
  path '/api/v1/email_trackings/stats' do
    get 'Lists Tracking URL with download hits counts' do
      tags 'EmailTrackings Stats'
      produces 'application/json'

      response '200', 'list of download hits' do
        schema type: :array, items: {
          type: :object,
          properties: {
            message_id: { type: :string },
            url: { type: :string },
            download_hits_count: { type: :integer }
          },
          required: [ 'message_id', 'url', 'download_hits_count' ]
        }

        before do
          EmailTracking.create!(message_id: '123abc@gmail.com')
        end

        run_test!
      end
    end
  end

  path '/api/v1/email_trackings' do
    post 'Create a new EmailTracking' do
      tags 'EmailTrackings'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :email_tracking, in: :body, schema: {
        type: :object,
        properties: {
          message_id: { type: :string }
        },
        required: [ 'message_id' ]
      }

      response '200', 'EmailTracking created' do
        schema type: :object,
               properties: {
                 uuid: { type: :string, example: '123e4567-e89b-12d3-a456-426614174000' },
                 url: { type: :string, example: 'https://localhost:3000/email_trackings/123e4567-e89b-12d3-a456-426614174000/download_hits/track' }
               },
               required: [ 'uuid', 'url' ]

        let(:email_tracking) { { message_id: '123abc@gmail.com' } }
        run_test!
      end

      response '422', 'Invalid request' do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Invalid message_id' }
               },
               required: [ 'error' ]

        let(:email_tracking) { { message_id: '' } }
        run_test!
      end
    end
  end
end
