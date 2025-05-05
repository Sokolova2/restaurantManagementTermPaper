class ChipBasketsController < ApplicationController
  def create
    table = session[:table_number]
    @chip_basket = ChipBasket.find_or_create_by(table_id: table)

    @chip_basket_item = @chip_basket.chip_basket_items.find_by(dish_and_drink_id: params[:dish_and_drink_id])

    if @chip_basket_item.present?
      @chip_basket_item.update(number_of_dish: @chip_basket_item.number_of_dish + params[:number_of_dish].to_i)
    else
      @chip_basket_item = ChipBasketItem.create(
        chip_basket: @chip_basket,
        dish_and_drink_id: params[:dish_and_drink_id],
        number_of_dish: params[:number_of_dish].to_i
      )
    end
  end

  def index
    table = session[:table_number]
    @chip_basket = ChipBasket.where(table_id: table).order(created_at: :desc).first
    @order = @chip_basket.table.order
    @total_price = @chip_basket.full_price
    if params[:table_id].present?
      flash[:notice] = "Ваше замовлення"
    end
  end

  def destroy
    table = session[:table_number]
    @chip_basket = ChipBasket.find_by(table_id: table)

    if @chip_basket.present?
      @chip_basket_item = @chip_basket.chip_basket_items.find_by(id: params[:id])

      if @chip_basket_item.present?
        @chip_basket_item.destroy
        redirect_to chip_baskets_path
      end
    end
  end
end

