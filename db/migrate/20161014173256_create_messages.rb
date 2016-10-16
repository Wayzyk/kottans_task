class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.string :encryption_type
      t.string :link
      t.integer :visit_count, default: 0
      t.string :secret_code
      t.integer :destruct_number, default: 1
      t.timestamps
    end
  end
end
