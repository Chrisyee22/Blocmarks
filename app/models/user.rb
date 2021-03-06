class User < ApplicationRecord
before_save { self.email = email.downcase }

has_many :topics
has_many :bookmarks, dependent: :destroy
has_many :likes, dependent: :destroy

def liked(bookmark)
  likes.where(bookmark_id: bookmark.id).first
end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable,  :validatable, authentication_keys: [:login]
  attr_accessor :login

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end

    def to_s
     username
    end

    protected
    def confirmation_required?
      false
    end
end
