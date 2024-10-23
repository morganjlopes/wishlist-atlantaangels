class Admin::ListsController < Admin::BaseController

  def index
    @page_title = "Wishlists"
    @lists      = List.all
  end

  def show
    @list       = List.find(params[:id])
    @page_title = @list.name
  end
end
