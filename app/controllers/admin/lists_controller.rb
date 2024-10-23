class Admin::ListsController < Admin::BaseController

  def index
    @page_title = "Wishlists"
    @lists      = List.all
    if params[:family_id].present?
      @family = Family.friendly.find(params[:family_id])
      @lists      = @lists.where(family_id: @family.id)
    end
  end

  def show
    @list       = List.find(params[:id])
    @page_title = @list.name
  end
end
