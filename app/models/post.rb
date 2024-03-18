class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'no_image.jpg')
    end
    image
  end
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  def bookmarked_by?(user)
    bookmarks.exists?(user_id: user.id)
  end
 
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :polishing_low, -> {order(polishing: :asc)}
  scope :polishing_high, -> {order( polishing: :desc)}
  scope :score_low, -> {order(score: :asc)}
  scope :score_high, -> {order(score: :desc)}
  scope :recommend_low, -> {order(recommend: :asc)}
  scope :recommend_high, -> {order(recommend: :desc)}
  scope :label_low, -> {order(label: :asc)}
  scope :label_high, -> {order(label: :desc)}
  scope :scent_low, -> {order(scent: :asc)}
  scope :scent_high, -> {order(scent: :desc)}
  scope :taste_low, -> {order(taste: :asc)}
  scope :taste_high, -> {order(taste: :desc)}
  scope :sweet_low, -> {order(sweet: :asc)}
  scope :sweet_high, -> {order(sweet: :desc)}
  scope :acidity_low, -> {order(acidity: :asc)}
  scope :acidity_high, -> {order(acidity: :desc)}
  scope :bitter_low, -> {order(bitter: :asc)}
  scope :bitter_high, -> {order(bitter: :desc)}
  scope :umami_low, -> {order(umami: :asc)}
  scope :umami_high, -> {order(umami: :desc)}
  scope :attack_low, -> {order(attack: :asc)}
  scope :attack_high, -> {order(attack: :desc)}
  scope :complexity_low, -> {order(complexity: :asc)}
  scope :complexity_high, -> {order(complexity: :desc)}
  scope :after_flavor_low, -> {order(after_flavor: :asc)}
  scope :after_flavor_high, -> {order(after_flavor: :desc)}
  scope :lingering_low, -> {order(lingering: :asc)}
  scope :lingering_high, -> {order(lingering: :desc)}
  scope :price_low, -> {order(price: :asc)}
  scope :price_high, -> {order(price: :desc)}
  
  validates :image, presence: true
  validates :sake, presence: true
  validates :score, presence: true
  validates :polishing, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :specific, presence: true
  
  
  enum prefecture:{
     "選択してくだい":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }

end
