class Post < ApplicationRecord
  belongs_to :user

  broadcasts_refreshes

  validates :message, length: { minimum: 1, maximum: 280 }
end
