class EmailTracking < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :download_hits, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  validates :message_id, presence: true, uniqueness: true
  validates :url, presence: true

  before_validation :generate_uuid, :generate_tracking_url, on: :create

  scope :with_download_hits_count, lambda {
    left_joins(:download_hits)
      .select("email_trackings.url, COUNT(download_hits.id) AS download_hits_count")
      .group("email_trackings.id")
  }

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end

  def generate_tracking_url
    protocol = Rails.env.production? ? "https" : "http"
    host = ENV.fetch("API_HOST", "localhost:3000")
    self.url ||= track_api_v1_email_tracking_download_hits_url(uuid, host: host, protocol: protocol)
  end
end
