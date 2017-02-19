class Project < ApplicationRecord
  belongs_to :team

  has_many :accesses
  has_many :users, through: :accesses
  has_many :todos

  validates_presence_of :team_id, :title
end
