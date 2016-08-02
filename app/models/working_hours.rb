class WorkingHours

  #http://stackoverflow.com/questions/4027768/calculate-number-of-business-days-between-two-days
  def absence_days startDate, endDate, employeeId
    business_days = []
    if startDate != "" && endDate != ""
      startDate = DateTime.parse(startDate)
      endDate = DateTime.parse(endDate)
      for i in 0..different_days(startDate, endDate) + 1
        current_day = startDate + i.days
        if (!current_day.saturday? && !current_day.sunday?) && fail_to_work?(employeeId, current_day)
          business_days << current_day
        end
      end
    end
    return business_days
  end

  def different_days startDate, endDate
    different_day = (((endDate.to_time - startDate.to_time) / 1.days) - 1 )
    different_day *= -1 if different_day < 0
    return different_day
  end

  def assistance_day params
    if params[:startDate] != ""
      worked_days = Schedule.where("employee_id = ? and DATE(date) >= ? and DATE(date) <= ?",params[:id],params[:startDate], params[:endDate]).order(:date)
    else
      worked_days = Schedule.where("employee_id = ? and DATE(date) = ?",params[:id],params[:startDate]).order(:date)
    end
    return {:days => worked_days}
  end

  private

  #%F - The ISO 8601 date format (%Y-%m-%d)
  def fail_to_work? employeeId, date
    Schedule.where("employee_id = ? and DATE(date) = ?",employeeId, date.strftime("%F")).size == 0
  end

end
