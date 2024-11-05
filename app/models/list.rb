class List < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :family
  belongs_to :sponsor, optional: true

  has_many :list_items, dependent: :destroy

  accepts_nested_attributes_for :list_items, allow_destroy: true

  scope :published,   -> { where(is_published: true) }
  scope :pending,     -> { where.not(is_published: true) }
  scope :sponsorable, -> { published.where(sponsor_id: nil) }
  scope :sponsored,   -> { published.where.not(sponsor_id: nil).order(sponsored_at: :desc) }

  pg_search_scope :contains,
                  against: [
                    :name,
                  ],
                  using: { tsearch: { prefix: true } }

  validates :name,            presence: true
  validates :age,             presence: true

  before_save :_ensure_alias

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

  def _ensure_alias
    return if self.alias.present?

    until self.alias.present? && List.where(alias: self.alias).empty?
      self.alias = SecureRandom.random_number(1_000..9_999).to_s
    end
  end
end

