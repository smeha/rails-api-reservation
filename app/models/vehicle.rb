class Vehicle < ApplicationRecord
  belongs_to :customer
  has_one :time_slot, dependent: :destroy
  validates :make, :model, presence: true
  accepts_nested_attributes_for :time_slot, allow_destroy: true
  validates :vin, presence: true, uniqueness: { case_sensitive: false }
end
