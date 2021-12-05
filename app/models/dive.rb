class Dive < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :dive_comments, dependent: :destroy
end
