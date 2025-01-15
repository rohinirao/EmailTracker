require 'swagger_helper'

RSpec.describe 'API::V1::EmailTrackings', type: :request do
  path '/api/v1/email_trackings' do
    post 'Create a new EmailTracking' do
      tags 'EmailTrackings'
      consumes 'application/json'
      parameter name: :email_tracking, in: :body, schema: {
        type: :object,
        properties: {
          message_id: { type: :string }
        },
        required: [ 'message_id', 'uuid' ]
      }

      response '200', 'EmailTracking created' do
        let(:email_tracking) { { message_id: '123abc@gmail.com' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:email_tracking) { { message_id: '' } }
        run_test!
      end
    end
  end
end
