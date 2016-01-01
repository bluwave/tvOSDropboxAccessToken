class CreateAccess < ActiveRecord::Migration
  def change
    create_table :access do |t|
      t.string :tv_token
      t.string :dropbox_access_token

      t.timestamps null: false
    end
  end
end
