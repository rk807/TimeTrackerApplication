class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :view_timesheet_chart, :chart]

  # GET /employees
  # GET /employees.json
  

  def view_timesheet_chart 
    start_date= "2013-08-01"
    end_date="2013-11-01"
    @employee_id = params[:id]
    @employee_details_with_timesheets =  Timesheet.find_with_timesheets_in_date_range(@employee_id,start_date,end_date)
    if(!@employee_details_with_timesheets.nil?)
      @employee_details_with_timesheets = @employee_details_with_timesheets[0]
    else
     @employee_details_with_timesheets =nil;
     end

     #render json:@employee_details_with_timesheets

     @h = LazyHighCharts::HighChart.new('bar') do |f|
        f.chart({:defaultSeriesType=>'bar' , :margin=> [50, 200, 60, 170]} )

       #data = {:name=>'Nanda', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9]}
        #data =  render @employee_details_with_timesheets.to_json
        
       


    f.series(:name=>'Johnss', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
     f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
      #renders xml: @employee
     
    
     #f.series(json:@employee_details_with_timesheets)
     #render json:data.to_json
    
    end

    
end

  def index
    @employees = Employee.all
    @timesheets = Timesheet.all
    # render json:@employees
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.timesheets.build
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employee }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end


 def chart
    @h = LazyHighCharts::HighChart.new('line') do |f|
        f.chart({:defaultSeriesType=>'line' , :margin=> [50, 200, 60, 170]} )


      f.series(:name=>'Johnss', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
     # f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
      #render xml: @employee
      f.series(@employee_details_with_timesheets);
    end 
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name)
    end
end
