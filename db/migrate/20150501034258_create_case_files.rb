class CreateCaseFiles < ActiveRecord::Migration
  def change
    create_table :case_files do |t|
      t.integer :client_id
      t.string :name
      t.string :matter
      t.string :file_no
      t.date :date_opened
      t.date :date_closed
      t.string :location

      t.timestamps null: false
    end
  end
end
