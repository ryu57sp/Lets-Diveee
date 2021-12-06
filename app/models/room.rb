class Room < ApplicationRecord

  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

end
