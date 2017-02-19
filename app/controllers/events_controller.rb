class EventsController < ApplicationController
  def index
    @events = Event.all
    if params[:last_id].present?
      @events = @events.where(" id > ?", params[:last_id].to_i)
    end
    @events = @events.order(id: :desc).last(50)

    respond_to do |format|
      format.js {
        render json: {
          now: DateTime.now.strftime('%s'),
          events: @events.map(&:to_message),
          last_id: @events.first&.id
        }
      }
      format.html 
    end
  end
end
