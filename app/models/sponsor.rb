class Sponsor < ApplicationRecord
  extend FriendlyId
  friendly_id :_sluggable, use: :slugged

  has_many :lists

  attr_accessor :redirect_url

  validates :full_name, presence: true
  validates :email,     presence: true
  validates :address,   presence: true

  def _sluggable
    SecureRandom.uuid
  end
end
