class InitializeBrandStoreAndJoinTables < ActiveRecord::Migration[5.1]
  def change
    create_table :brands do |t|
      t.column :name, :string
      t.column :price, :integer
    end

    create_table :joins do |t|
      t.column :brand_id, :integer
      t.column :store_id, :integer
    end

    create_table :stores do |t|
      t.column :name, :string
    end
  end
end
