class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # ActionCable.server.broadcast "messages_#{message.receiver.id}", data
    ActionCable.server.broadcast "events_#{args[0].user.id}", 
      { title: 'New things!', body: 'All the news that is fit to print' }
  end
end
