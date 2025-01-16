class Api::V1::EmailTrackingSerializer < ActiveModel::Serializer
  attributes :url, :download_hits_count

  def download_hits_count
    object.download_hits_count
  end
end
