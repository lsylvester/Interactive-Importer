ActiveRecord::Schema.define do
  create_table :people, :force => true do |t|
    t.string :first_name, :last_name
    t.timestamps
  end
  
  create_table :csv_rows, :force => true do |t|
    t.integer :number
    t.text :content
    t.integer :csv_import_id
    t.timestamps
  end
  
  create_table :csv_imports, :force => true do |t|
    t.string   :file_name
    t.string   :target
    t.string   :type
    t.timestamps
  end
end