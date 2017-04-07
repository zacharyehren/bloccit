class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
#the inclusion validation ensures that value is assigned either a -1 or 1
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true
end
