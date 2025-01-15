FactoryBot.define do
  factory :email_tracking do
    uuid { Faker::Internet.uuid }
    message_id { "<#{Faker::Internet.uuid}-wrwre@example.com>" }
    url { "/api/v1/email_trackings/#{uuid}/download_hits/track" }
  end
end
