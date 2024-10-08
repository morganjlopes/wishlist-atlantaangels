class Family < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :event

  has_many :lists, dependent: :destroy

  validates :name,    presence: true
  validates :phone,   presence: true
  validates :email,   presence: true
  validates :address, presence: true
end
