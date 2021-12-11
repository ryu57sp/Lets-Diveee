class Hashtag < ApplicationRecord

  validates :hashname, presence: true, length: {maximum: 15}
  has_many :hashtag_relations, dependent: :destroy
  has_many :dives, through: :hashtag_relations

end
