class Like < ApplicationRecord
	belongs_to :chef
	belongs_to :recipe
	
	# this arranges foa chef to only like/dislike a reicpe once. chef_id can only be associated w/ a like & recipe once
	validates_uniqueness_of :chef, scope: :recipe
end