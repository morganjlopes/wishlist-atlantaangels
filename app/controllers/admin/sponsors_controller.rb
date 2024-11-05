class Admin::SponsorsController < Admin::BaseController
  before_action :set_sponsor, only: %i[ show edit update destroy ]

  def index
    @page_title    = "Sponsors"
    @sponsors      = Sponsor.all
    @sponsors      = @sponsors.send(params[:scope]) if params[:scope].present?
    @sponsors      = @sponsors.contains(params[:q]) if params[:q].present?

    respond_to do |format|
      format.html
      format.csv { send_data @sponsors.to_csv }
    end
  end

  def show
    @page_title = @sponsor.full_name
  end

  def edit
  end

  def update
    respond_to do |format|
      if @sponsor.update(sponsor_params)
        format.html { redirect_to sponsor_url(@sponsor), notice: "Sponsor was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sponsor.destroy

    respond_to do |format|
      format.html { redirect_to sponsors_url, notice: "Sponsor was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sponsor_params
      params.require(:sponsor).permit(:full_name, :email, :phone, :address, :redirect_url)
    end
end
