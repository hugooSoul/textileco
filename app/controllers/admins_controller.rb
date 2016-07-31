class AdminsController < ApplicationController


  def index
    @employees = Employee.all
  end

  def show

  end


  private


end
