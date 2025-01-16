class Api::V1::EmailTrackingStatsSerializer < ActiveModel::Serializer
  attributes :message_id, :url, :download_hits_count

  def download_hits_count
    object.download_hits_count
  end
end
