class SponsorsController < ApplicationController
  before_action :set_sponsor, only: %i[ show edit update destroy ]

  def index
    @sponsors = Sponsor.all
  end

  def show
  end

  def new
    @sponsor = Sponsor.new(redirect_url: session[:redirect_url])
  end

  def edit
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)

    respond_to do |format|
      if @sponsor.save
        session[:sponsor_id] = @sponsor.id
        format.html { redirect_to @sponsor.redirect_url, notice: "Sponsor was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
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
      @sponsor = Sponsor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sponsor_params
      params.require(:sponsor).permit(:full_name, :email, :phone, :address, :redirect_url)
    end
end
