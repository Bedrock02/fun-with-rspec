require 'spec_helper'

describe Link do
  before(:each) do
    #Changed the create so that I am making a link
    #that contains a comment
  	@link = FactoryGirl.create(:link)
  end

  it "has a url" do
    @link.url.should be_present
  end

  it "has a score" do
    @link.score.should be_present
  end

  it "belongs to a user" do
  	user = FactoryGirl.create(:user)
  	user.links << @link

  	@link.user.should == user
  end

  context "with comments" do
  	
    before(:each) do
  		@link = FactoryGirl.create(:link_with_comment)
  	end

    it "has a comment" do
      @link.comments.should be_present
     
    end
  end

  it "should update it's score" do
    @link.updateScore
    @link.score.should == 1
  end


  context "with comments" do
    #comment = FactoryGirl.create(:comment)
    #@link.comments << comment
    before(:each) do
      @link = FactoryGirl.create(:link_with_comment)
    end

    it "after comment updates link_id parent cumulative score should be incremented" do
      @link.score.should == 1
    end
  end


  context "with multiple comments" do
    before(:each) do
      @link = FactoryGirl.create(:link_with_multiple_comments)
    end

    it "should have more than one comment" do
      @link.comments.count.should > 1
    end

    it "cumalitve score should be the total score of all comments that was added upon creation" do
          
      ## This one is tricky. You'll have to have several lines of code here. 
      ## The idea is that a link with 2 comments, one of a score 2, the other of a score 3, 
      ## will have a composite score of 5.

      ## A hint is that you may want to leverage the after_save callback of the 
      ## comment method to maybe update the parent link.
      
      cumulativeScore = 0
      @link.comments.each do |com|
        cumulativeScore += com.score
      end

      @link.score.should == cumulativeScore
    end
  
    it "vote_up should increment cumulativeScore by 1" do
      link = FactoryGirl.create(:link_with_comment) #cumaltive score should be 1
      link.comments.first.vote_up
      link.comments.first.score == link.score
    end


    it "updates its cumulative score when a comment gets a score" do
       ## This one is tricky. You'll have to have several lines of code here. 
      ## The idea is that a link with 2 comments, one of a score 2, the other of a score 3, 
      ## will have a composite score of 5.

      ## A hint is that you may want to leverage the after_save callback of the 
      ## comment method to maybe update the parent link.

      ##QUSTION: How come it works in the example above, but when I do this in a loop it 
      #for some reason only updates the child(comment) and not the parent?
      
      cumulativeScore = 0 
      @link.comments.each do |child|
        child.vote_up
        cumulativeScore += child.score
      end

      @link.score.should == cumulativeScore
    end 

  end

  it "addComment should add an individual comment" do
    before = @link.comments.count

    comment = FactoryGirl.create(:comment)
    @link.addComment(comment)
    after = @link.comments.count

    after.should > before
    
  end

  




end
