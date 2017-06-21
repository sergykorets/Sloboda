class AddAdminToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_column :authors, :admin, :boolean, default: false
  end
end
