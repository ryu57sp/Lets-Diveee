class DiveComment < ApplicationRecord
  belongs_to :user
  belongs_to :dive
  belongs_to :dive_comment, foreign_key: :reply, optional: true
  has_many :replies, class_name: 'DiveComment', foreign_key: :reply, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
