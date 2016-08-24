class SchedulesController < ApplicationController

  before_action :is_admin?
  before_action :find_schedule, only: [:show, :edit, :update]

  def index
    #@schedules = Schedule.where(user_id: current_employee).order("DESC")
    @employee = current_employee
  end

  def report
    if params[:id]
      @working_time = Employee.get_employee_review params
      if !@working_time[:available]
        flash[:message] = "You havent't permission to review your Schedule, only available three days before the paycheck day."
        render 'report'
      end
    else
      render 'index'
    end
  end

  def show

  end

  def new
    @schedule = current_employee.schedules.build
  end

  def create
    worktime1 = current_employee.schedules.build(date: DateTime.parse("#{params[:date]} #{params[:checkin]}"))
    worktime2 = current_employee.schedules.build(date: DateTime.parse("#{params[:date]} #{params[:checkout]}"))
    #@schedule = current_employee.schedules.build(schedule_params)

    if worktime1.save && worktime2.save
      #format.html { render 'index', notice: 'Schedule was successfully stored.' }
      flash[:notice] = "Schedule was successfully saved."
      #render 'index'
      redirect_to schedules_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule
    else
      render 'edit'
    end
  end

  private

  def find_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:date)
  end


  def is_admin?
    if current_employee.admin?
      redirect_to admins_path
    end
  end


end
