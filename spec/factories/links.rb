# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
  	url "http://myfavorite.com/thing"
  	score 0
  end

  factory :link_with_comment, parent: :link do
  	after(:create) do |link|
  	  FactoryGirl.create(:comment, link:link)
  	end
  end

	factory :link_with_multiple_comments, parent: :link do
		after(:create) do |link|
			FactoryGirl.create(:comment, link:link)
			FactoryGirl.create(:comment, link:link)
		end
	end
end