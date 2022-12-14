class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books,dependent: :destroy
         has_many :favorites,dependent: :destroy
         has_many :book_comments, dependent: :destroy

        # フォローをした、されたの関係
        has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
        has_many :followings, through: :relationships, source: :followed  #自分がフォローしている人の一覧表示のための記述

        has_many :reverce_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
        has_many :followers, through: :reverce_of_relationships, source: :follower #自分がフォローされている人の一覧表示のための記述

        # ユーザーをフォローする定義
        def follow(user_id)
          relationships.create(followed_id: user_id)
        end

        # ユーザのフォローを外す定義
        def unfollow(user_id)
          relationships.find_by(followed_id: user_id).destroy
        end

        # ユーザをフォローしているかの判定
        def following?(user)
          followings.include?(user)
        end

        # user検索方法分岐
        def self.looks(search, word)
          if search == "perfect_match"
            @user = User.where("name LIKE?", "#{word}")
          elsif search == "forward_match"
            @user = User.where("name LIKE?", "#{word}%")
          elsif search == "backward_match"
            @user = User.where("name LIKE?", "%#{word}")
          elsif search == "partial_match"
            @user = User.where("name LIKE?", "%#{word}%")
          else
            @user = User.all
          end
        end

  has_one_attached :profile_image
  # バリデーション
  validates :name,presence: true,uniqueness: true,length: {minimum:2, maximum:20}
  validates :introduction,length: {maximum:50}

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path),filename: 'default-image.jpg',content_type:'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

end
