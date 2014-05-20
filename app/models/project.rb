class Project < ActiveRecord::Base
	validates :name,presence:true,uniqueness:true
	validates :description,presence:true
	has_many :issues
	belongs_to :user
end
