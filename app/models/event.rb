class Event < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :user

  # after_create :send_to_client

  # def send_to_client
  #   new_message = {:message => "#{entity_type}. #{entity_id}, #{action}"}
  #   # send_message :event_name, new_message
  #   WebsocketRails.users[user.id]
  #     .send_message('new_event', {:message => 'you\'ve got an upvote '})
  # end

  def to_message
    { id: id,
      message: message
    }
  end

  def message
    "#{entity_type}, #{entity_id}, #{entity.title}"
  end
end
