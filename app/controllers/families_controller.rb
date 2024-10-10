class FamiliesController < ApplicationController
  before_action :_set_event
  before_action :set_family, only: %i[ show edit update lists_complete confirmation destroy ]

  def index
    @page_title = "Families"
    @families   = Family.all
  end

  def show
    @page_title = @family.name
  end

  def new
    @page_title = "New Family"
    @family     = Family.new
  end

  def edit
    @page_title = "Edit Family"
  end

  def lists_complete
    if @family.update(lists_completed_at: Time.current)
      redirect_to confirmation_event_family_path(@family.event, @family), notice: "Your wishlists are complete."
    else
      redirect_to event_family_confirmation_path(@family.event, @family), alert: "There was an error."
    end
  end

  def confirmation
    @page_title = "Confirmation"
  end

  def create
    @family       = @event.families.new(family_params)
    @family.event = @event

    respond_to do |format|
      if @family.save
        redirect_url = @family.is_support_requested ? new_event_family_list_path(@family.event, @family) : confirmation_event_family_path(@family.event, @family)
        format.html { redirect_to redirect_url, notice: "Family was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @family.update(family_params)
        format.html { redirect_to event_family_url(@family.event, @family), notice: "Family was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @family.destroy

    respond_to do |format|
      format.html { redirect_to families_url, notice: "Family was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def family_params
      params.require(:family).permit(
        :name,
        :phone,
        :email,
        :address,
        :holiday,
        :wrap_gifts,
        :household_caregivers_count,
        :household_children_count,
        :slug,
        :is_attending,
        :is_support_requested,
        :attendance_selection
      )
    end
end
