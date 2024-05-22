class Comment < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :prototype

  validates :content, presence: true

end
