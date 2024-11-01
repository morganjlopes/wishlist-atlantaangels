class Family < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :event

  has_many :lists, dependent: :destroy

  scope :pending,           -> { where(lists_completed_at: nil) }
  scope :completed,         -> { where.not(lists_completed_at: nil) }
  scope :support_requested, -> { where(is_support_requested: true) }

  pg_search_scope :contains,
                  against: [
                    :name,
                    :phone,
                    :email,
                    :address
                  ],
                  using: { tsearch: { prefix: true } }

  validates :name,    presence: true
  validates :phone,   presence: true
  validates :email,   presence: true
  validates :address, presence: true
  
  def lists_count
    lists.count
  end

  def event_name
    event&.name
  end

  def self.to_csv
    attrs = [
      "id",
      "name",
      "phone",
      "email",
      "address",
      "event_name",
      "holiday",
      "wrap_gifts",
      "is_support_requested",
      "is_attending",
      "attendance_selection",
      "lists_count",
      "household_caregivers_count",
      "household_children_count",
      "slug",
      "created_at",
      "lists_completed_at",
    ]

    CSV.generate do |csv|
      csv << attrs
    
      all.each do |family|
        csv << attrs.map {|attr| family.send(attr)}
      end
    end
  end
end
