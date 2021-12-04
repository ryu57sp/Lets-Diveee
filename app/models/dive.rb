class Dive < ApplicationRecord
  attachment :image
  belongs_to :user
end
