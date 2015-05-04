class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.references :course, index: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
