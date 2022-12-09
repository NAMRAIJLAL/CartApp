class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.json :categories
      t.integer :user_id
      t.timestamps
    end
  end
end
