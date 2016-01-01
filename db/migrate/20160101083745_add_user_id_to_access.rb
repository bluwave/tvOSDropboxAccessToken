class AddUserIdToAccess < ActiveRecord::Migration
  def change
    add_column :access, :user_id, :string
  end
end
