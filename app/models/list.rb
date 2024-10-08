class List < ApplicationRecord
  belongs_to :family

  has_many :list_items, dependent: :destroy

  accepts_nested_attributes_for :list_items, allow_destroy: true

  validates :name,            presence: true
  validates :age,             presence: true
end

