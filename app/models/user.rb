class User < ApplicationRecord
  include PgSearch::Model
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :trackable

  pg_search_scope :contains,
                  against: [
                    :first_name,
                    :last_name,
                  ],
                  using: { tsearch: { prefix: true } }
end
