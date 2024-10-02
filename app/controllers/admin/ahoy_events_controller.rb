class Admin::AhoyEventsController < Admin::BaseController
  def index
    @page_title     = 'Events'
    @events         = Ahoy::Event.order(time: :desc)
    @events         = @events.send(params[:scope]) if params[:scope].present?
    @pagy, @events  = pagy(@events)
    @scopes         = {
      'All'    => nil,
      'Recent' => 'recent',
    }
  end
end
