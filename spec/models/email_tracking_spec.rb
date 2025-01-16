require 'rails_helper'

RSpec.describe EmailTracking, type: :model do
  subject { FactoryBot.create(:email_tracking) }

  it { should validate_presence_of(:uuid) }
  it { should validate_uniqueness_of(:uuid) }
  it { should validate_presence_of(:message_id) }
  it { should validate_uniqueness_of(:message_id) }
  it { should validate_presence_of(:url) }

  it "generates a UUID and URL before creation" do
    email_tracking = described_class.create!(message_id: "<#{Faker::Internet.uuid}-test@example.com>")
    expect(email_tracking.uuid).not_to be_nil
    expect(email_tracking.url).to eq("http://localhost:3000/api/v1/email_trackings/#{email_tracking.uuid}/download_hits/track")
  end
end
