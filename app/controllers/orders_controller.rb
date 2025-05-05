class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :accept_order, :mark_dish_done, :mark_paid]

  def create
    table = session[:table_number]
    @chip_basket = ChipBasket.find_by(table_id: table)
    @order = Order.find_or_create_by(
      table_id: @chip_basket.table_id,
      employee_id: nil,
      order_status: "Оформлено"
    )

    if @order.present?
      @chip_basket.chip_basket_items.each do |item|
        OrderItem.create(
          order_id: @order.id,
          dish_and_drink_id: item.dish_and_drink_id,
          number_of_dishes: item.number_of_dish,
          dish_status: "Готується"
        )

        @chip_basket.chip_basket_items.destroy_all
      end
    end
  end

  def show
    @order_items = @order.order_items
    @employee_name = session[:employee_name]
  end

  def accept_order
    if @order.present? && session[:employee_id]
      @order.update(
        employee_id: current_employee.id,
        order_status: "Прийнято"
      )
    end
    redirect_to @order, notice: "Замовлення прийнято"
  end

  def mark_dish_done
    if @order.order_status == "Прийнято"
      @order_items = @order.order_items.find_by(id: params[:order_item_id])
      if @order_items.present?
        @order_items.update(
          dish_status: "Виконано",
          )
      end
    end
    redirect_to @order

    if @chip_basket.present?
      @chip_basket_item = @chip_basket.chip_basket_items.find_by(id: params[:id])

      if @chip_basket_item.present?
        @chip_basket_item.destroy
        redirect_to chip_basket_chip_baskets_path
      end
    end
  end

  def mark_paid
    @order_items = @order.order_items
    if @order.order_status == "Прийнято" && @order_items.all? { |item| item.dish_status == "Виконано" && @order.order_status != "Сплачено"}
      @order.update(
      order_status: "Сплачено",
      )
    end
    redirect_to dish_and_drinks_path
  end

  private

  def set_order
    table = session[:table_number]
    @order = Order.where(table_id: table).where.not(order_status: "Сплачено").first
  end

  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]
  end
end
