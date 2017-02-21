class Comment < ApplicationRecord
  belongs_to :todo
  belongs_to :user

  after_create :log_into_events
  # 7.  评论任务。

  def log_into_events
    todo.events.create(action: 'todo_comment', user_id: user.id)
  end


end
