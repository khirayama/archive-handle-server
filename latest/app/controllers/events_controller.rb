class EventsController < ApplicationController
  before_action :authenticate

  def index
    @events = Event.where('start_time > ?', Time.zone.now).order(:start_time)
  end

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

  def edit
    @event = current_user.created_events.find(params[:id])
  end

  def update
    @event = current_user.created_events.find(params[:id])
    if @event.update(event_params)
      redirect_to @event, notice: 'Updated'
    else
      render :edit
    end
  end

  private

    def event_parmas
      params.require(:event).permit(
        :name, :place, :content, :start_time, :end_time
      )
    end
end
