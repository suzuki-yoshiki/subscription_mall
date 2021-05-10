class AddAdminCheckPrivateToOwners < ActiveRecord::Migration[5.1]
  def change
    add_column :owners, :admin_check_private, :string
  end
end
