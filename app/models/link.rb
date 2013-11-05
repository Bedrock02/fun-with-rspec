class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  
  def updateScore
  	self.score += 1
  	self.save
  end

  def addComment(com)
  	self.comments << com
  	self.save
  	self.score += com.score
  	self.save
  end

  def seeScore
  	puts self.score
  end

end
