class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :schedules

  def self.get_employee_review params
    hash = Hash.new
    today = Time.now
    payday_one = 15
    payday_two = today.end_of_month.day
    if check_available? payday_one, payday_two
      hash[:available] = true
      if today.day < payday_one
        hash[:startDate] = today - (today.day - 1).days
        hash[:endDate] = (today - (today.day - 1).days) + 15.days
      else
        hash[:startDate] = (today - (today.day - 1).days) + 15.days
        hash[:endDate] = (today - (today.day - 1).days) + payday_two.days
      end
      hash[:id] = params[:id]
      hash[:option] = "check"
      hash[:worked_days] = get_report hash
      return hash
    else
      hash[:available] = false
      return hash
    end
  end

  #getting the days of the employee abscence into a range of days
  #From To && Employee ID
  def self.get_report params #absence
    if params[:option] == "" || params[:option] == "check"
      return get_inputs_outputs assistance_day(params)
    else
      days = WorkingHours.new
      return days.absence_days params[:startDate], params[:endDate], params[:id]
    end
  end

  def self.assistance_day params
    if params[:startDate] != ""
      assits_days = Schedule.where("employee_id = ? and DATE(date) >= ? and DATE(date) <= ?",params[:id],params[:startDate], params[:endDate]).order(:date)
      #assits_days = assits_days[1]
    else
      assits_days = Schedule.where("employee_id = ? and DATE(date) = ?",params[:id],params[:startDate]).order(:date)
    end
    return assits_days #{:days => assits_days}
  end

  def self.get_inputs_outputs assits_days
    check = WorkingHours.new
    check.get_info_of_day assits_days
  end

  private

  def self.check_available? dayOne, dayTwo
    today = Time.now
    if !(dayOne - today.day == 3 || dayTwo - today.day == 3)
      return false
    else
      return true
    end
  end

end
