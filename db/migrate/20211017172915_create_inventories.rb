class CreateInventories < ActiveRecord::Migration[6.1]
  def change
    create_table :inventories do |t|
      t.string :name
      t.references :company
      t.references :created_by
      t.boolean :approved
      t.datetime :status_updated_at

      t.timestamps
    end
  end
end
