class CreateCourseraInstructors < ActiveRecord::Migration
  def change
    create_table :coursera_instructors, id: false do |t|
      t.integer :id, null: false
      t.string :photo
      t.string :photo150
      t.string :bio
      t.string :prefixName
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :suffixName
      t.string :fullName
      t.string :title
      t.string :department
      t.string :website
      t.string :websiteTwitter
      t.string :websiteFacebook
      t.string :websiteLinkedin
      t.string :websiteGplus
      t.string :shortName

      t.timestamps
    end
    add_index :coursera_instructors, :id, unique: true
  end
end
