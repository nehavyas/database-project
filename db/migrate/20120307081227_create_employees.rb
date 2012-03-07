class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :hashed_password
      t.string :salt

      t.timestamps
    end
  end
end
