class ApplicationController < ActionController::Base
  include Pagy::Backend
  after_action :track_action

  protected

  def track_action
    ahoy.track "action_success", request.path_parameters
  end

  def _set_event
    @event = Event.friendly.find(params[:event_id])
  end

  def _set_family
    @family = Family.friendly.find(params[:family_id])
  end
end
