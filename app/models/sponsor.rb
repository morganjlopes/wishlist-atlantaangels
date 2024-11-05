class Sponsor < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :_sluggable, use: :slugged

  has_many :lists

  attr_accessor :redirect_url

  scope :without_lists, -> { includes(:lists).where(lists: { id: nil }) }
  scope :with_lists,    -> { includes(:lists).where.not(lists: { id: nil }) }

  pg_search_scope :contains,
                  against: [
                    :full_name,
                    :email,
                    :phone,
                    :address,
                  ],
                  using: { tsearch: { prefix: true } }

  validates :full_name, presence: true
  validates :email,     presence: true
  validates :address,   presence: true

  def self.to_csv
    attrs = [
      "id",
      "full_name",
      "email",
      "phone",
      "address",
    ]

    CSV.generate do |csv|
      csv << attrs
    
      all.each do |family|
        csv << attrs.map {|attr| family.send(attr)}
      end
    end
  end

  def _sluggable
    SecureRandom.uuid
  end
end
