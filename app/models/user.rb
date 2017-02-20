class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :team
  has_many :events
  has_many :comments
  has_many :todos, foreign_key: :recipient_id

  has_many :accesses
  has_many :projects, through: :accesses
end
