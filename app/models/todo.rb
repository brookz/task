class Todo < ApplicationRecord
  has_many :events, as: :entity
  has_many :comments
  belongs_to :recipient, class_name: 'User', required: false
  belongs_to :project

  attr_accessor :operator_id

  validates_presence_of :title, :operator_id, :project_id
  # 1.  创建任务;
  # 2.  删除任务;
  # 3.  完成任务;
  # 4.  给任务指派完成者;
  # 5.  修改任务完成者;
  # 6.  修改任务完成时间;
  after_commit :log_into_events, on: [:create, :update]

  # 更适合的是放在controller#action中记录event, 用在这里便于调试
  def log_into_events
    if self.id_previously_changed?
      events.create(action: 'todo_create', user_id: operator_id)
    elsif self.recipient_id_previously_changed? && self.recipient_id_was.blank?
      events.create(action: 'todo_dispatch', user_id: operator_id)
    elsif self.recipient_id_previously_changed?
      events.create(action: 'todo_dispatch_edit', user_id: operator_id, attr_changes: previous_changes.to_s)
    elsif self.etd_previously_changed?
      events.create(action: 'todo_etd_set', user_id: operator_id, attr_changes: previous_changes.to_s)
    elsif self.finished_at_previously_changed?
      events.create(action: 'todo_finished', user_id: operator_id)
    elsif self.status_previously_changed? && self.status == -1
      events.create(action: 'todo_destroy', user_id: operator_id)
    end
  end


end
