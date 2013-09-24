class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :user, :uniqueness => {:scope => :post}
end
