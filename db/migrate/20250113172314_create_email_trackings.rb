class CreateEmailTrackings < ActiveRecord::Migration[8.0]
  def change
    create_table :email_trackings do |t|
      t.string :uuid, null: false
      t.string :message_id, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :email_trackings, :uuid, unique: true
    add_index :email_trackings, :message_id, unique: true
  end
end
