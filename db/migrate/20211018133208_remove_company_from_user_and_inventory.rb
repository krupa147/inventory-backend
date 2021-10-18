class RemoveCompanyFromUserAndInventory < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :company_id
    remove_column :inventories, :company_id
  end
end
