class PaymentsController < ApplicationController

  def index
    table = session[:table_number]
    @order = Order.where(table_id: table).where.not(order_status: "Сплачено").first
  end

  def pay
    table = session[:table_number]
    @order = Order.where(table_id: table).where.not(order_status: "Сплачено").first

    if @order.present?
      amount = params[:amount].to_f
      begin
        charge = Stripe::Charge.create(
          amount: (amount * 100).to_i,
          currency: 'uah',
          source: params[:stripeToken],
          description: "Оплата за замовлення",
          )

        Rails.logger.info "Оплата успішна для замовлення"

        if @order.present?
          @order.update(order_status: "Сплачено")
          Rails.logger.info "Статус оновлено: #{@order.id} - Сплачено"
        end

      rescue Stripe::CardError => e
        flash[:error] = e.message
      rescue Stripe::InvalidRequestError => e
        flash[:error] = "Ошибка: #{e.message}"
      end
    else
      flash[:error] = "Замовлення не знайдено"
    end
  end
end
