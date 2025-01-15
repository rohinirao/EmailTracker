class DownloadHit < ApplicationRecord
  belongs_to :email_tracking

  validates :ip_address, presence: true
  validates :user_agent, presence: true
end
