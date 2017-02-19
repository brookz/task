class User < ApplicationRecord
  belongs_to :team
  has_many :events
  has_many :comments
  has_many :todos, foreign_key: :recipient_id

  has_many :accesses
  has_many :projects, through: :accesses
end
