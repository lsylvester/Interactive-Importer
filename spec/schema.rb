ActiveRecord::Schema.define do
  create_table :people do |t|
    t.string :first_name, :last_name, :email
    t.datetime :date_of_birth
    t.timestamps
  end
end