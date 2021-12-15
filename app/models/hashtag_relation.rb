class HashtagRelation < ApplicationRecord
  belongs_to :dive
  belongs_to :hashtag
  with_options presence: true do
    validates :dive_id
    validates :hashtag_id
  end
end
