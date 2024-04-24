class CreateSyncTimesRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :sync_times_records do |t|
      t.string :record_name
      t.datetime :last_sync_time
      t.string :sync_by
      t.timestamps
    end
  end
end
