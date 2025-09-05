class ListsController < ApplicationController
  before_action :_check_api_key, only: %i[ feed ]
  before_action :_set_event
  before_action :_set_family, except: %i[ index show claim feed ]
  before_action :set_list, only: %i[ show edit update destroy claim ]

  def index
    @lists = List.sponsorable

  end
  
  def feed
    @lists = List.sponsored
    
    respond_to do |format|
      format.json
    end
  end

  def show
  end

  def claim
    if session[:sponsor_id].present? && Sponsor.exists?(session[:sponsor_id])
      @list.update(
        sponsor_id: session[:sponsor_id],
        sponsored_at: Time.now
      )

      redirect_to event_list_path(@event, @list), notice: "Wishlist was successfully claimed."
    else
      session[:redirect_url] = claim_event_list_path(@event, @list)

      redirect_to new_sponsor_path
    end
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
      @list = List.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_params
      params.require(:list).permit(
        :family_id,
        :name,
        :age,
        :gender,
        :is_qualified,
        :qualification_criteria,
        :gift_card_store,
        list_items_attributes: %i[id name url _destroy]
      )
    end
end
