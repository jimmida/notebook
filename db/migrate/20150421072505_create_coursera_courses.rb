class CreateCourseraCourses < ActiveRecord::Migration
  def change
    create_table :coursera_courses, id: false do |t|
      t.integer :id, null: false
      t.string :shortName
      t.string :name
      t.string :language
      t.string :largeIcon
      t.string :photo
      t.string :previewLink
      t.string :shortDescription
      t.string :smallIcon
      t.string :smallIconHover
      t.string :subtitleLanguagesCsv
      t.boolean :isTranslate
      t.string :universityLogo
      t.string :universityLogoSt
      t.string :video
      t.string :videoId
      t.string :aboutTheCourse
      t.string :targetAudience
      t.string :faq
      t.string :courseSyllabus
      t.string :courseFormat
      t.string :suggestedReadings
      t.string :instructor
      t.string :estimatedClassWorkload
      t.string :aboutTheInstructor
      t.string :recommendedBackground

      t.timestamps
    end
    add_index :coursera_courses, :id, unique: true
  end
end