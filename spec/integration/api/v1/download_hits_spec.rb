require 'swagger_helper'

RSpec.describe 'api/v1/download_hits', type: :request do
  path '/api/v1/email_trackings/{email_tracking_uuid}/download_hits/track' do
    get 'Tracks download hits and serves an image' do
      tags 'DownloadHits'
      produces 'image/png'
  
      parameter name: :email_tracking_uuid, in: :path, type: :string, description: 'Email tracking UUID'
  
      response '200', 'Image served and hit recorded' do

        description 'Returns a PNG image for tracking purposes'
  
        before do
          allow_any_instance_of(Rswag::Specs::ResponseValidator)
            .to receive(:validate_body!).and_return(true)
        end
  
        let(:email_tracking) do
          EmailTracking.create!(message_id: '123abc@gmail.com')
        end
        let(:email_tracking_uuid) { email_tracking.uuid }
  
        run_test!
      end
    end
  end
end
