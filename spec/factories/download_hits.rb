FactoryBot.define do
  factory :download_hit do
    ip_address { '127.0.0.1' }
    user_agent { 'RSpec Test Agent' }
    association :email_tracking
  end
end
