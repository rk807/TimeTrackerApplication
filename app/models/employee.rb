class Employee < ActiveRecord::Base

	has_many :timesheets, :dependent=> :destroy
	def self.find_with_timesheets_in_date_range(id, start_date, end_date)
    conditions="id =? and log_date between ? and ?"
    employee_details_with_timesheets=self.find(:all, :include=>'timesheets', :conditions=> [conditions,id,start_date,end_date], :order=>'log_date asc')
    return employee_details_with_timesheets
end
end
