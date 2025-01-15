require 'rails_helper'

RSpec.describe DownloadHit, type: :model do
  let(:email_tracking) { EmailTracking.create!(message_id: "<#{Faker::Internet.uuid}-test@example.com>", uuid: SecureRandom.uuid, url: 'example.com') }

  it 'is valid with valid attributes' do
    download_hit = DownloadHit.new(email_tracking: email_tracking, ip_address: '127.0.0.1', user_agent: 'Mozilla/5.0')
    expect(download_hit).to be_valid
  end

  it 'is invalid without an ip_address' do
    download_hit = DownloadHit.new(email_tracking: email_tracking, user_agent: 'Mozilla/5.0')
    expect(download_hit).not_to be_valid
    expect(download_hit.errors[:ip_address]).to include("can't be blank")
  end

  it 'is invalid without a user_agent' do
    download_hit = DownloadHit.new(email_tracking: email_tracking, ip_address: '127.0.0.1')
    expect(download_hit).not_to be_valid
    expect(download_hit.errors[:user_agent]).to include("can't be blank")
  end
end
