class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.text :name

      t.timestamps
    end
  end
end
