class Admin::FamiliesController < Admin::BaseController

  def index
    @page_title = "Families"
    @families   = Family.all
  end

  def show
    @family     = Family.friendly.find(params[:id])
    @page_title = @family.name
  end
end
