class Event < ApplicationRecord
  belongs_to :entity, polymorphic: true
  belongs_to :user

  after_create :send_to_client

  def send_to_client
    ActionCable.server.broadcast "receiver:#{user.id}", 
      {
        id: id, name: user.name, action: I18n.t(action), 
        title: entity.title, created_at: created_at.to_s(:short)
      }
  end

end
