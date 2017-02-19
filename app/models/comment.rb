class Comment < ApplicationRecord
  has_many :events, as: :entity
  # 7.  评论任务。
end
