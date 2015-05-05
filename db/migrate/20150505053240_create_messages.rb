class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_for
      t.string :message_date
      t.string :caller
      t.string :phone_number
      t.text :message
      t.string :message_taker
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :messages, [:user_id, :created_at]
  end
end
