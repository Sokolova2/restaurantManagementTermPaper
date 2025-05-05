class TablesController < ApplicationController
  def index
    @table = Table.all
  end

  def show
    @table = Table.find_by(table_number: params[:id])

    session[:table_number] = @table.table_number unless @table.nil?

    redirect_to dish_and_drinks_path
  end
end
