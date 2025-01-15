class EmailTracking < ApplicationRecord
  has_many :download_hits, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  validates :message_id, presence: true, uniqueness: true
  validates :url, presence: true

  before_validation :generate_uuid_and_url, on: :create

  scope :with_download_hits_count, lambda {
    left_joins(:download_hits)
      .select("email_trackings.url, COUNT(download_hits.id) AS download_hits_count")
      .group("email_trackings.id")
  }

  private

  def generate_uuid_and_url
    self.uuid ||= SecureRandom.uuid
    self.url ||= "/api/v1/email_trackings/#{uuid}/download_hits/track"
  end
end
