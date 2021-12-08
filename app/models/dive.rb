class Dive < ApplicationRecord
  attachment :image

  belongs_to :user
  has_many :dive_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :dive_point, presence: true
  validates :water_temperature, presence: true
  validates :season, presence: true
  validates :dive_shop, presence: true

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #通知機能に関して
  def create_notification_favorite!(current_user)
    #すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and dive_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(dive_id: id, visited_id: user_id, action: "favorite")
      #自分の投稿に対するいいねの場合は通知済みとする
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save
    end
  end

  def create_notification_comment!(current_user, dive_comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = DiveComment.select(:user_id).where(dive_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, dive_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, dive_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, dive_comment_id, visited_id)
    #コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(dive_id: id, dive_comment_id: dive_comment_id, visited_id: visited_id, action: "comment")
    #自分の投稿に対するコメントの場合は、通知済みとする
    notification.checked = true if notification.visitor_id == notification.visited_id
    notification.save if notification.valid?
  end

end