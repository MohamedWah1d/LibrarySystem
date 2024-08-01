class RenameIsAdminToUserTypeInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :is_admin, :user_type
  end
end
