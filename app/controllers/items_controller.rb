class ItemsController < ApplicationController
	before_action :set_list
	
  def create
    @item = @list.items.create(item_params)
    redirect_to list_path(@list)
  end

  def destroy
  	@item = @list.items.find(params[:id])
  	if @item.destroy
      flash[:success] = "Item was deleted."
    else
      flash[:error] = "Item was not deleted."
    end
    redirect_to @list
  end

  private

    def set_list
      @list = List.find(params[:list_id])
    end

    def item_params
      params.require(:item).permit(:content)
    end
  
  
end
