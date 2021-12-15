class Bookmark < ApplicationRecord
  validates :user_id, uniqueness: { scope: :dive_id }
  belongs_to :user
  belongs_to :dive
end
