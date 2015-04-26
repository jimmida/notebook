class CreateCourseraCategories < ActiveRecord::Migration
  def change
    create_table :coursera_categories, id: false do |t|
      t.integer :id, null: false
      t.string :name
      t.string :shortName
      t.string :description

      t.timestamps
    end
    add_index :coursera_categories, :id, unique: true
  end
end
