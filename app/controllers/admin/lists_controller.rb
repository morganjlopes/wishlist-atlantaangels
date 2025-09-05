class Admin::ListsController < Admin::BaseController
  before_action :_set_list, only: [:show, :edit, :remove_sponsor, :update, :destroy]

  def index
    @page_title = "Wishlists"
    @lists      = List.all
    @lists      = @lists.send(params[:scope]) if params[:scope].present?
    @lists      = @lists.contains(params[:q]) if params[:q].present?
    
    if params[:family_id].present?
      @family = Family.friendly.find(params[:family_id])
      @lists      = @lists.where(family_id: @family.id)
    end

    respond_to do |format|
      format.html
      format.csv { send_data @lists.to_csv }
    end
  end

  def show
    @page_title = @list.name
  end

  def edit
    @page_title = 'Edit Wishlist'
  end

  def remove_sponsor
    @list.remove_sponsor!

    redirect_to admin_lists_path(), notice: "Sponsor removed successfully"
  end

  def update
    if @list.update(list_params)
      redirect_to edit_admin_list_path(@list), notice: "Wishlist updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy

    redirect_to admin_lists_path, notice: "Wishlist deleted successfully"
  end

  private

  def _set_list
    @list = List.friendly.find(params[:id])
  end

  def list_params
    params.require(:list).permit(
      :name,
      :age,
      :gender,
      :gift_card_store,
      :is_published,
      :alias, 
      list_items_attributes: [
        :id,
        :name,
        :url,
        :_destroy
      ]
    )
  end
end
