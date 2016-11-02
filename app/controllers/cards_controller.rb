class CardsController < ApplicationController
  
  def create
    input = params.require(:box_add_card_to_box_action).permit(:front, :back)
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
  
end
