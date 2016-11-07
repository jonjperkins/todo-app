class ItemsController < ApplicationController
	before_action :set_list
	before_action :set_item, except: [:create]
	
  def create
    @item = @list.items.create(item_params)
    redirect_to list_path(@list)
  end

  def destroy
  	if @item.destroy
      flash[:success] = "Item was deleted."
    else
      flash[:error] = "Item was not deleted."
    end
    redirect_to @list
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to @list, notice: "Item completed"
  end

  private

    def set_item
      @item = @list.items.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    def item_params
      params.require(:item).permit(:content)
    end
  
  
end
