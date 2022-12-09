class CreateUsercarts < ActiveRecord::Migration[6.0]
  def change
    create_table :usercarts do |t|
      t.integer :user_id
      t.json :items
      t.timestamps
    end
  end
end
