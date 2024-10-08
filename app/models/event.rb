class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :families, dependent: :destroy
  
  validates :name,        presence: true
  validates :description, presence: true
end
