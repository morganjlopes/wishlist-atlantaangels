class EventsController < ApplicationController
  before_action :set_event, only: %i[ show ]

  def index
    @page_title = "Events"
    @events     = Event.all

    redirect_to new_event_family_path(@events.first) if @events.count == 1
  end

  def show
    @page_title       = @event.name
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end
end
