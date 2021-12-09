class DiveComment < ApplicationRecord
  belongs_to :user
  belongs_to :dive
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
