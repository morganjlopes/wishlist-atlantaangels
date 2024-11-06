class Admin::ListItemsController < Admin::BaseController

  def index
    @page_title = "Wishlist Items"
    @list_items = ListItem.all
    @list_items = @list_items.contains(params[:q]) if params[:q].present?

    respond_to do |format|
      format.html
      format.csv { send_data @list_items.to_csv }
    end
  end
end
