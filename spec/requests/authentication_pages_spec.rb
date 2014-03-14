require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }

	describe "signin page" do
		before { visit signin_path }
		it { should have_content('Sign in') }
		it { should have_title('Sign in')}
		
	end	

	describe "with invalid information" do
      #before { click_button "Sign In" }

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error') }
      
		describe "after visiting another page" do
			before {click_link "home"}
			it { should_not have_selector('div.alert.alert-error') }

		end
	end	
=begin
  describe "GET /authentication_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get authentication_pages_index_path
      response.status.should be(200)
    end
  end

=end  
end
