class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :course, index: true
      t.references :lesson, index: true
      t.text :content

      t.timestamps
    end
  end
end
