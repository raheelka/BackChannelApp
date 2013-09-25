class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :comment_votes, :dependent => :destroy
  validates :content, :presence => true, :length => { :maximum => 160 }
end
