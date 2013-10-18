class TimesheetsController < ApplicationController
  before_action :set_timesheet, only: [:show, :edit, :update, :destroy]

  # GET /timesheets
  # GET /timesheets.json
  def index
    @timesheets = Timesheet.all
  end

  def view_timesheet_chart 
    start_date= "2008-12-01"
    end_date="2008-12-07"
    @employee_id = params[:id]
    employee_details_with_timesheets =  Timesheet.find_with_timesheets_in_date_range(@employee_id,start_date,end_date)
    if(!employee_details_with_timesheets.nil?)
        @employee_details_with_timesheets =employee_details_with_timesheets[0]
    else
      @employee_details_with_timesheets =nil;
    end
      headers["content-type"]="text/html"
end


  # GET /timesheets/1
  # GET /timesheets/1.json
  def show
  end

  # GET /timesheets/new
  def new
    @timesheet = Timesheet.new
  end

  # GET /timesheets/1/edit
  def edit
  end

def report_hours

  @reportHours = Timesheet.sum(:hours_spent, :group => :employee_id)
  # myjson = @reportHours.collect{|timesheet| :name=>"0", :data=>[10] }.to_json
   
  #render json:myjson


    @h = LazyHighCharts::HighChart.new('bar') do |f|
    f.chart({:defaultSeriesType=>'bar' , :margin=> [50, 200, 60, 170]} )

        f.series(:name=>"0", :data=>[10])
      

       # f.series(json:@reportHours)
end
end



  #render json:@reportHours


  # POST /timesheets
  # POST /timesheets.json
  def create
    @timesheet = Timesheet.new(timesheet_params)

    respond_to do |format|
      if @timesheet.save
        format.html { redirect_to @timesheet, notice: 'Timesheet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @timesheet }
      else
        format.html { render action: 'new' }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timesheets/1
  # PATCH/PUT /timesheets/1.json
  def update
    respond_to do |format|
      if @timesheet.update(timesheet_params)
        format.html { redirect_to @timesheet, notice: 'Timesheet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timesheets/1
  # DELETE /timesheets/1.json
  def destroy
    @timesheet.destroy
    respond_to do |format|
      format.html { redirect_to timesheets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timesheet
      @timesheet = Timesheet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_params
      params.require(:timesheet).permit(:log_date, :hours_spent, :employee_id)
    end
end
