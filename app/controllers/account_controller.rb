class AccountController < ApplicationController
  def index
    if params[:id].present? && params[:password].present?
      @employee = Employee.find_by(id: params[:id], password: params[:password])

      if @employee&.job_title =="Офіціант"
        session[:employee_id] = @employee.id
        session[:employee_name] = "#{@employee.last_name} #{@employee.first_name} #{@employee.parent_name}".strip
        redirect_to dish_and_drinks_path
      elsif @employee&.job_title == "Керівник"
        session[:employee_id] = @employee.id
        session[:employee_name] = "#{@employee.last_name} #{@employee.first_name} #{@employee.parent_name}".strip
        redirect_to managers_path
      else
        flash[:error] = "Cпівробітника не знайдено"
      end
    else
      flash[:error] = "ID та пароль обов'язкові"
    end
  end

  def logout
    session[:employee_id] = nil
    session[:employee_password] = nil
    redirect_to dish_and_drinks_path
  end
end
