json.array!(@timesheets) do |timesheet|
  json.extract! timesheet, :log_date, :hours_spent, :employee_id
  json.url timesheet_url(timesheet, format: :json)
end
