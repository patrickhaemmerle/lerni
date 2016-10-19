class BoxesController < ApplicationController
  
  def index
    result = Box::ListBoxesForUserQuery.perform user_id: current_user[:id]
    @boxes = result.boxes
  end
  
  def new
    @create_box_action = Box::CreateBoxAction.new
  end
  
  def create
    input = params.require(:box_create_box_action).permit(:name)
    input[:user_id] = current_user[:id]
    @create_box_action = Box::CreateBoxAction.perform input 
    if @create_box_action.success?
      redirect_to boxes_path
    else
      render "new"
    end
  end
  
end
