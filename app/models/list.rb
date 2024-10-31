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

end

