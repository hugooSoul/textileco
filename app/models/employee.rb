class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name
  validates_presence_of :last_name
  has_many :schedules

  #getting the days of the employee abscence into a range of days
  #From To && Employee ID
  def self.get_report params
    if params[:option] == "" || params[:option] == "absence"
      days = WorkingHours.new
      return days.absence_days params[:startDate], params[:endDate], params[:id]
    else
      days = WorkingHours.new
      return days.assistance_day(params)
    end
  end


end
