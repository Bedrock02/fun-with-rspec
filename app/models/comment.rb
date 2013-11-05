class Comment < ActiveRecord::Base
  belongs_to :link
 	
 	after_save :updateParent
  after_update :updateParent

 	def vote_up
 		self.score += 1
 		self.save
  end

  def updateParent
  	
  	if self.parent.nil?
  		return
  	else
  		self.parent.updateScore
  	end
  
  end
 	
 	def parent
 		return self.link
 	end

end
