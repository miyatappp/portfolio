class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 8 }
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_users, through: :followers, source: :followed
  has_many :follower_users, through: :followeds, source: :follower
  
  def follow(user_id)
  followers.create(followed_id: user_id)
  end

  def unfollow(user_id)
  followers.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
  following_users.include?(user)
  end	 
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
end
