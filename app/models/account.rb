class Account < ActiveRecord::Base
	#associations	
	belongs_to :user
	has_many :transactions, dependent: :destroy

	# validations
	validates :email, presence: true, email: true
	validates :phone, numericality: { only_integer: true }
	validates :phone, length: { is: 10 }
	validates :address, length: { maximum: 100,
    too_long: "%{count} characters is the maximum allowed" }
end
