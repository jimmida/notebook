class CreateCourseraUniversities < ActiveRecord::Migration
  def change
    create_table :coursera_universities, id: false do |t|
      t.integer :id, null: false
      t.string :name
      t.string :shortName
      t.string :description
      t.string :banner
      t.string :homeLink
      t.string :location
      t.string :locationCity
      t.string :locationState
      t.string :locationCountry
      t.decimal :locationLat
      t.decimal :locationLng
      t.string :classLogo
      t.string :website
      t.string :websiteTwitter
      t.string :websiteFacebook
      t.string :websiteYoutube
      t.string :logo
      t.string :squareLogo
      t.string :landingPageBanner

      t.timestamps
    end
    add_index :coursera_universities, :id, unique: true
  end
end
