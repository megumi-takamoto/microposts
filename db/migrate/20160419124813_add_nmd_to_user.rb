class AddNmdToUser < ActiveRecord::Migration
  def change
    add_column :users, :nmd, :date
  end
end
