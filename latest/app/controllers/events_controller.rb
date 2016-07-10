class EventsController < ApplicationController
  before_action :authenticate

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_parmas)
    if @event.save
      redirect_to @event, notice: 'Created event'
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

    def event_parmas
      params.require(:event).permit(
        :name, :place, :content, :start_time, :end_time
      )
    end
end
