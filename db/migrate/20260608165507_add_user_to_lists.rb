class AddUserToLists < ActiveRecord::Migration[8.1]
  def up
    add_reference :lists, :user, null: true, foreign_key: true

    first_user_id = execute("SELECT id FROM users ORDER BY id LIMIT 1").first&.fetch("id")
    execute("UPDATE lists SET user_id = #{first_user_id}") if first_user_id

    change_column_null :lists, :user_id, false
  end

  def down
    remove_reference :lists, :user, foreign_key: true
  end
end
