class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :posts, :class_name => "Post", :foreign_key => "user_id"
  has_many :records, :class_name => "Post", :foreign_key => "author_id"

  validates :name, presence: true, length: { maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }


  has_secure_password

  validates :password, length: { minimum: 6 }

  has_attached_file :avatar,
                    styles: { :small => ["160x160#", :png],
                              :medium => ["214x214>", :png],
                              :original => ["600x450>", :png]},
                    :default_url => "/assets/images/default_:style.png",
                    :dependent => :destroy

  validates_attachment_file_name :avatar,
                                 :matches => [/png\z/, /jpg\z/, /jpeg\z/]




  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end


  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end
