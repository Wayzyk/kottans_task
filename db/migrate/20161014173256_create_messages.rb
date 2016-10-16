class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :encryption_type
      t.string :link
      t.boolean :is_visited
      t.string :secret_code
      t.timestamps
    end
  end
end
