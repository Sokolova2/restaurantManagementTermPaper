class ManagersController < ApplicationController
  before_action :set_order, only: [:show]
  before_action :date_filter, only: [:used_ingredients, :popular_dish, :tables_served_by_a_waitor]
  def index
    @manager_id = Employee.find_by(job_title: "Керівник")
  end

  def used_ingredients
    @group_dish = @order.group(:dish_and_drink_id).count
    @ingredients_count = Hash.new(0)

    @group_dish.each do |dish_id, count|
      @ingredients = Ingredient.where(dish_and_drink_id: dish_id)
      @ingredients.each do |ingredient|
        @ingredients_count[ingredient.name] += ingredient.grams * count
      end
    end
  end

  def popular_dish
    order_items = OrderItem.where(created_at: @start_date..@end_date)
    @group_dish = order_items.group(:dish_and_drink_id).count
    max_count = @group_dish.values.max
    @max_dishes = @group_dish.select { |dish_id, count| count == max_count }
    @max_dish_names = DishAndDrink.where(id: @max_dishes.keys).pluck(:name)

  end

  def tables_served_by_a_waitor
    orders = Order.where(created_at: @start_date..@end_date)
    @group_employee = orders.group(:employee_id).count
    @employees = Employee.where(id: @group_employee.keys)
  end

  # def waitor_of_tables
  #   @table = Table.all
  #   @tables = Table.where(table_number: params[:table_number])
  #   @employee = Employee.find_by(id: params[:employee_id], job_title: "Офіціант")
  #   if @tables.present?
  #     @tables.update(
  #       employee_id: @employee.id
  #     )
  #   end
  # end

  def dish_and_drink
    @dish_and_drink = DishAndDrink.all
  end

  def table
    @tables = Table.all
    @employee = Employee.where(job_title: "Офіціант")
  end

  def create

  end

  def update
    @table = Table.find(params[:id])
    if @table.update(employee_id: params[:table][:employee_id])
      redirect_to table_managers_path
    end
  end

  def destroy

  end

  def show
    @tables = Table.find_by(table_number: params[:id])

    redirect_to manager_show_path(@table)
  end

  private
  def set_order
    @order = Order.all
    @order_items = @order.order_items.all
  end
  def date_filter
    d = DateTime.now
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : d.beginning_of_month
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : d.end_of_month
    @order = OrderItem.where(created_at: @start_date..@end_date)
  end
end
