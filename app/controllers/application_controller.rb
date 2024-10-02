class ApplicationController < ActionController::Base
  include Pagy::Backend
  after_action :track_action

  protected

  def track_action
    ahoy.track "action_success", request.path_parameters
  end
end
