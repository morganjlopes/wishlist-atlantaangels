class ListItem < ApplicationRecord
  include PgSearch::Model
  belongs_to :list

  pg_search_scope :contains,
                  against: [
                    :name,
                  ],
                  using: { tsearch: { prefix: true } }

  validates :name, presence: true

  def event_name
    list&.family&.event&.name
  end

  def family_name
    list&.family&.name
  end

  def list_name
    list&.name
  end

  def list_alias
    list&.alias
  end

  def self.to_csv
    attrs = [
      "id",
      "name",
      "event_name",
      "family_name",
      "list_name",
      "list_alias",
    ]

    CSV.generate do |csv|
      csv << attrs
    
      all.each do |family|
        csv << attrs.map {|attr| family.send(attr)}
      end
    end
  end
end
