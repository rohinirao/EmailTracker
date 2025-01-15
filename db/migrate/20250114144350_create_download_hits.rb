class CreateDownloadHits < ActiveRecord::Migration[8.0]
  def change
    create_table :download_hits do |t|
      t.references :email_tracking, null: false, foreign_key: true
      t.string :user_agent, null: false
      t.string :ip_address, null: false

      t.timestamps
    end
  end
end
