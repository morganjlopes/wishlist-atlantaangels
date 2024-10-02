class Admin::AhoyVisitsController < Admin::BaseController
  def index
    @page_title    = 'Visits'
    @visits        = Ahoy::Visit.order(started_at: :desc)
    @visits        = @visits.send(params[:scope]) if params[:scope].present?
    @pagy, @visits = pagy(@visits)
  end
end
