class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.datetime :log_date
      t.integer :hours_spent
      t.integer :employee_id

      t.timestamps
    end
  end
end
