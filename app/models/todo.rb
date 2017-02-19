class Todo < ApplicationRecord
  has_many :events, as: :entity
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
  after_save :log_event_save
  after_destroy :log_event_destroy

  # 更适合的是放在action中记录event, 用在这里便于这个笔试的调试
  def log_event_save
    if self.id_changed?
      events.create(action: 'todo_create', user_id: operator_id)
    elsif self.recipient_id_changed? && self.recipient_id_was.blank?
      events.create(action: 'todo_dispatch', user_id: operator_id)
    elsif self.recipient_id_changed?
      events.create(action: 'todo_dispatch_edit', user_id: operator_id, attr_changes: previous_changes.to_s)
    elsif self.etd_changed?
      events.create(action: 'todo_etd_set', user_id: operator_id, attr_changes: previous_changes.to_s)
    elsif self.finished_at_changed?
      events.create(action: 'todo_finished', user_id: operator_id)
    end
  end

  def log_event_destroy
    events.create(action: 'todo_destroy', user_id: operator_id)
  end

end
