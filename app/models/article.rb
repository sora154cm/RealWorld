class Article < ApplicationRecord
  #titleとslugが空にならないように設定
  validates :title, presence: true
  validates :slug, presence: true
end
