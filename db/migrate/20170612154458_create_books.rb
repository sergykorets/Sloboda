class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :author_name	
      t.string :name
      t.text :content
      t.string :slug

      t.timestamps
    end
    add_index :books, :slug, unique: true
  end
end
