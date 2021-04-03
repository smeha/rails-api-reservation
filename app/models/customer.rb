class Customer < ApplicationRecord
	has_many :vehicles, dependent: :destroy	
	validates :first_name, :last_name, presence: true
	validate :unique_first_last_name
	accepts_nested_attributes_for :vehicles, allow_destroy: true

	def unique_first_last_name
		if Customer.where(:first_name => first_name, :last_name => last_name).exists?
			errors.add(:first_name, "name is not unique")
			errors.add(:last_name, "name is not unique")
		end
	end
end
