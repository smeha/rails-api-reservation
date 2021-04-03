class TimeSlot < ApplicationRecord
	belongs_to :vehicle
	validates :time, presence: true
	validate :time_special

	def time_special
		unless Time.zone.parse(time.to_s)
			errors.add(:time, "incorrect time")
		end
	end
end
