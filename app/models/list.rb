class List < ApplicationRecord
  include PgSearch::Model

  belongs_to :family

  has_many :list_items, dependent: :destroy

  accepts_nested_attributes_for :list_items, allow_destroy: true

  scope :published, -> { where(is_published: true) }
  scope :pending,   -> { where.not(is_published: true) }

  pg_search_scope :contains,
                  against: [
                    :name,
                  ],
                  using: { tsearch: { prefix: true } }

  validates :name,            presence: true
  validates :age,             presence: true

  def status
    if is_published
      'published'
    else
      'pending'
    end
  end

  def family_name
    family&.name
  end

  def event_name
    family&.event&.name
  end

  def list_items_count
    list_items.count
  end

  def self.to_csv
    attrs = [
      "id",
      "name",
      "event_name",
      "family_name",
      "age",
      "gender",
      "gift_card_store",
      "list_items_count",
      "created_at",
      "is_published",
    ]

    CSV.generate do |csv|
      csv << attrs
    
      all.each do |family|
        csv << attrs.map {|attr| family.send(attr)}
      end
    end
  end

end

