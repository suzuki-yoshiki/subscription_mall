class AddAdminCheckToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :admin_check, :string
  end
end
