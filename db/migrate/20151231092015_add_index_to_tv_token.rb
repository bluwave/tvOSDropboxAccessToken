class AddIndexToTvToken < ActiveRecord::Migration
  def change
    add_index :Access, :tv_token
  end
end
