class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  belongs_to :user, optional: true

  has_many :events, class_name: "Ahoy::Event"

  scope :recent, -> { where('started_at > ?', 1.week.ago).order(started_at: :desc) }
end
