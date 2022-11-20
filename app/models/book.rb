class Book < ApplicationRecord
  # 画像を許可
  has_one_attached :image
  belongs_to:user

  # バリデーション
  validates :title,presence: true
  validates :body,presence: true, length: {maximum:200}
  
end
