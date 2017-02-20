class Event < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :user

  after_create :send_to_client

  def send_to_client
    # EventNotificationJob.perform_later(self)
    ActionCable.server.broadcast "receiver:#{user.id}", 
      { title: 'New things!', body: 'All the news that is fit to print' }

    # EventsChannel.broadcast_to(
    #   user,
    #   title: 'New things!',
    #   body: 'All the news fit to print'
    # )
    puts "=== action cable broadcast ==="
  end

  def to_message
    { id: id,
      message: message
    }
  end

  def message
    "#{entity_type}, #{entity_id}, #{entity.title}"
  end
end
