class Book < ApplicationRecord
  # 画像を許可
  has_one_attached :image
  belongs_to:user
end
