class Timesheet < ActiveRecord::Base
belongs_to :employee, :foreign_key => 'id'

		def self.find_with_timesheets_in_date_range(id, start_date, end_date)
    conditions="id =? and log_date between ? and ?"
    @employee_details_with_timesheets=self.find(:all, :select => "id, hours_spent", :conditions=> [conditions,id,start_date,end_date], :order=>'log_date asc')
    return @employee_details_with_timesheets
end
end