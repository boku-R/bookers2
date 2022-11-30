class Book < ApplicationRecord
  # 画像を許可
  has_one_attached :image
  belongs_to:user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # バリデーション
  validates :title,presence: true
  validates :body,presence: true, length: {maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
