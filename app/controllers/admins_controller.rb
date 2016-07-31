class AdminsController < ApplicationController


  def index
    @employees = Employee.all
  end

=begin
  def show
  end
=end

  def report
    @employee = Employee.find(params[:id])
  end


  private


end
