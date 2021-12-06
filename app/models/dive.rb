class Dive < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :dive_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :image_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :dive_point, presence: true
  validates :water_temperature, presence: true
  validates :season, presence: true
  validates :dive_shop, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
