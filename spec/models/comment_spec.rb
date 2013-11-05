require 'spec_helper'

describe Comment do
  before(:each) do
    @link = FactoryGirl.create(:link_with_comment)
    @comment = @link.comments.first
  end

  it "has a score" do
    @comment.score.should be_present
  end

  it "belongs to a link" do
    @comment.link.should == @link
  end

  it "increments the score" do
    ## this simulates the vote-up functionality.
    @comment.vote_up
    @comment.score.should == 2
  end
end
