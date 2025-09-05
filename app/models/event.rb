class Event < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :families, dependent: :destroy
  has_many :lists,    through: :families
  has_many :sponsors, -> { distinct.order('sponsors.full_name ASC') }, through: :lists
  
  validates :name,        presence: true
  validates :description, presence: true
end
