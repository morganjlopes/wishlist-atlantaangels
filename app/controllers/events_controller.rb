class EventsController < ApplicationController
  before_action :set_event, only: %i[ show ]

  def index
    @page_title = "Events"
    @events     = Event.all
  end

  def show
    @page_title = @event.name
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end
end
