class Dive < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :log_comments, dependent: :destroy
end
