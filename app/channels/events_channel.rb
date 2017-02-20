class EventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "receiver:#{current_user.id}"
    puts "test subscribed"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


end
