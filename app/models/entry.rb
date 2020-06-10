class Entry < ApplicationRecord

  validates :amount, :activity_date, :expense, presence: true

  belongs_to :category

  scope :for_today, -> (date = Date.today) { includes(:category).where( activity_date: date ) }
end
