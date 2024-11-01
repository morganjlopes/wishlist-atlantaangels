class Admin::FamiliesController < Admin::BaseController
  before_action :_set_family, only: [:show, :edit, :update]

  def index
    @page_title = "Families"
    @families   = Family.all
    @families   = @families.send(params[:scope]) if params[:scope].present?
    @families   = @families.contains(params[:q]) if params[:q].present?

    respond_to do |format|
      format.html
      format.csv { send_data @families.to_csv }
    end
  end

  def show
    @page_title = @family.name
  end

  def edit
    @page_title = 'Edit Family'
    @family     = Family.friendly.find(params[:id])
  end

  def update
    if @family.update(family_params)
      redirect_to admin_families_path, notice: "Family updated successfully"
    else
      render :edit
    end
  end

  private

  def _set_family
    @family = Family.friendly.find(params[:id])
  end

end
