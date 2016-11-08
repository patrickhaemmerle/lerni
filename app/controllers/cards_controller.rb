class CardsController < ApplicationController
  
  def create
    input = params.require(:formdata).permit(:front, :back)
    input[:user_id] = @current_user[:id]
    input[:box_id] = params[:box_id]
    
    @formdata = Box::AddCardToBoxAction.perform input
    
    if @formdata.success? || @formdata.errors.details.key?(:box_id)
      redirect_to boxes_path
    else
      render "new"
    end
  end
  
  def new
    @formdata = Box::AddCardToBoxAction.new
  end
  
  def index
    input = {}
    input[:user_id] = @current_user[:id]
    input[:box_id] = params[:box_id]
    result = Box::ListCardsForBoxQuery.perform input
    if result.success?
      @cards = result.cards
    else
      redirect_to boxes_path
    end
  end
  
end
