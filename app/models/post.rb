class Post < ActiveRecord::Base

  belongs_to :user
  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  validates :content, :presence => true, :length => { :maximum => 160 }
  validates :user_id, :presence => true
end
