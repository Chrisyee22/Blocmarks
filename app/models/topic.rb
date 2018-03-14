class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks

  validates :title, length:{minimum: 1}, presence: true
  validates :title, presence: true
end
