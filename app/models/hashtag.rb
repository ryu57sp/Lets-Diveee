class Hashtag < ApplicationRecord

  validates :hashname, presence: true, length: {maximum: 15}
  has_many :hashtag_relations
  has_many :dives, through: :hashtag_relations

end
