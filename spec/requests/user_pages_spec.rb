require 'spec_helper'

describe "UserPages" do
	
  subject {page}

  describe "profile page" do
    let( :user) {FactoryGirl.create(:user)}
    before {visit user_path(user)} 
      it {should have_content(user.name)}
      it {should have_title(user.name)} 
  end  
  
  describe "signup page" do
  	before { visit signup_path }

=begin

  	let(:submit) { "Create my account" }

  	describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

  	describe "with valid information" do


  		before do
			fill_in "user_name" with: "Example User"
			fill_in "user_email" with: "example_u@g.com"
			fill_in "password" with: "qazwsxedc"
			fill_in "confirm_password" with: "qazwsxedc"

			click_button "Create My Account"
		end
		it "should create a user" do
        	expect { click_button submit }.to change(User, :count).by(1)
      	end
  	end	
=end

  end

	
	


=begin	
  describe "GET /user_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get user_pages_index_path
      response.status.should be(200)
    end
  end
=end 
end
