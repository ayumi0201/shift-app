class Employee::SchedulesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index]

  def index
    @schedules = current_employee.schedules
  end
end
