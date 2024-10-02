class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :recent, -> { where('created_at > ?', 1.week.ago).order(created_at: :desc) }
end
