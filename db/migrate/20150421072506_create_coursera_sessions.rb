class CreateCourseraSessions < ActiveRecord::Migration
  def change
    create_table :coursera_sessions, id: false do |t|
      t.integer :id, null: false
      t.integer :courseId
      t.string :homeLink
      t.integer :status
      t.boolean :active
      t.string :durationString
      t.integer :startDay
      t.integer :startMonth
      t.integer :startYear
      t.string :name
      t.datetime :signatureTrackCloseTime
      t.datetime :signatureTrackOpenTime
      t.float :signatureTrackPrice
      t.float :signatureTrackRegularPrice
      t.boolean :eligibleForCertificates
      t.boolean :eligibleForSignatureTrack
      t.string :certificateDescription
      t.boolean :certificatesReady

      t.timestamps
    end
    add_index :coursera_sessions, :id, unique: true
  end
end