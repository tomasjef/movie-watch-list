class AddUniqueIndexToListsNameUserid < ActiveRecord::Migration[8.1]
  def change
    remove_index :lists, :name if index_exists?(:lists, :name)
    add_index :lists, [:user_id, :name], unique: true
  end
end
