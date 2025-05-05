class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]
  def index
    @employee = Employee.all
  end

  def show

  end

  def create
    @employee = Employee.create(employee_params)
  end

  def update
    if @employee.present?
      @employee.update(employee_params)
    end
  end

  def destroy
    if @employee.present?
      @employee.tables.update_all(employee_id: nil)
      @employee.destroy
    end
    redirect_to employees_path
  end

  private
  def set_employee
    @employee = Employee.find_by(id: params[:id])
  end

  def employee_params
    params.require(:employee).permit(:last_name, :first_name, :parent_name, :job_title, :phone_number, :password)
  end
end
