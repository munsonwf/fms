class RemoveMessageFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :messages, :text
  end
end
