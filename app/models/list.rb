class List < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :alias, use: :slugged

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
  
  validate :_prevent_update_if_published

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

  def sponsor_name
    sponsor&.full_name
  end

  def remove_sponsor!
    update(sponsor_id: nil)
  end

  def self.to_csv
    attrs = [
      "id",
      "name",
      "alias",
      "event_name",
      "family_name",
      "age",
      "gender",
      "gift_card_store",
      "list_items_count",
      "created_at",
      "is_published",
      "sponsor_name",
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

  def _prevent_update_if_published
    if is_published
      errors.add(:base, "Cannot update a published list")
      false
    end
  end
end

