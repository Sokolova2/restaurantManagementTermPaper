class DishAndDrinksController < ApplicationController
  before_action :set_dishes_and_drinks, only: %i[dishes bar]
  before_action :set_dish_and_drink, only: [:show, :update]

  def index
    table = session[:table_number]
    @order = Order.where(table_id: table).where.not(order_status: "Сплачено").order(created_at: :desc).first
    @employee = Employee.find_by(id: session[:employee_id])
  end

  def bar
    @category = 'Drink'
    filter_by_category
  end

  def dishes
    @category = 'Food'
    filter_by_category
  end

  def show

  end

  def create
    @dish_and_drink = DishAndDrink.create(menu_params)
  end

  def update
    if @dish_and_drink.present?
      @dish_and_drink.update(menu_params)
    end
  end

  # def search
  #   @search = DishAndDrink.ransack(params[:q])
  #   @search_dishes = @search.result(distinct: true)
  #   flash[:notice] = "Pезультати пошуку" if params[:q].present?
  # end

  private

  def menu_params
    params.require(:dish_and_drink).permit(:name, :grams, :category, :category_type, :price)
  end

  def set_dish_and_drink
    @dish_and_drink = DishAndDrink.find_by(id: params[:id])
  end

  def set_dishes_and_drinks
    @menu = DishAndDrink.all
  end

  def filter_by_category
    if params[:category].present?
      @filter_category = @menu.where(category_type: params[:category])
    else
      @filter_category = @menu.where(category: @category)
    end
  end
end
