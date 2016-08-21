class WorkingHours

  #require 'business_time'

  #BusinessTime::Config.beginning_of_workday = "9:00 am"
  #BusinessTime::Config.end_of_workday = "6:00 pm"

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

  def get_info_of_day assits_days
    hash = Hash.new
    #get the date & hour of the check-in & check-out turning that into an array
    days_array = []
    assits_days.each { |d| days_array << d.date }
    ######################################################################
    #puts assits_days.size.to_i
    if assits_days.size > 1
      hash = get_worked_days(days_array, hash)
    end
    return hash
  end

  def different_days startDate, endDate
    different_day = (((endDate.to_time - startDate.to_time) / 1.days) - 1 )
    different_day *= -1 if different_day < 0
    return different_day
  end

  private

  #%F - The ISO 8601 date format (%Y-%m-%d)
  def fail_to_work? employeeId, date
    Schedule.where("employee_id = ? and DATE(date) = ?",employeeId, date.strftime("%F")).size == 0
  end

  #http://www.tutorialspoint.com/ruby/ruby_date_time.htm
  #https://learnrubythehardway.org/book/ex32.html
  #Turning the cyclo
  def get_worked_days days_array, hash
    position = 0
    position2 = 1
    days_array.each do |d|
      if d.day != days_array[position].day
        hash = return_info hash, days_array[position], days_array[position2]
        position+=2
        position2+=2
      elsif days_array.index(d) == days_array.size - 1
      #  puts days_array.index(d)
        hash = return_info hash, days_array[position], days_array[position2]
      end
    end
    return hash
  end

  def return_info hash, check_in_hour, check_out_hour
    came_late = check_in_hour.strftime("%H:%M")
    if came_late >= "09:30"
      late_message = "came late!"
    end
    left_early = check_out_hour.strftime("%H:%M")
    if left_early >= "15:00" && left_early <= "17:45"
      left_message = "left early!"
    end
    hash["#{check_in_hour.strftime("%F")}"] = { check_in: check_in_hour, check_out: check_out_hour, late: late_message, early: left_message}
    return hash
  end

end
