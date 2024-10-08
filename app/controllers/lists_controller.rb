class ListsController < ApplicationController
  before_action :_set_event
  before_action :_set_family
  before_action :set_list, only: %i[ show edit update destroy ]

  def index
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
    @list.list_items.build
  end

  def edit
  end

  def create
    @list = @family.lists.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to new_event_family_list_path(@family.event, @family), notice: "List was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to new_event_family_list_path(@family.event, @family), notice: "List was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url, notice: "List was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(
        :family_id,
        :name,
        :age,
        :gender,
        :gift_card_store,
        list_items_attributes: %i[id name _destroy]
      )
    end
end
