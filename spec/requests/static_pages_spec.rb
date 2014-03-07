require 'spec_helper'

#subject { page }
describe "StaticPages" do
 
  describe "Home page" do
  	#before { visit root_path }

  	it "should have the content 'Welcome'" do
  		visit home_path
  		expect(page).to have_content('Welcome')
  	end
  end

  describe "About page" do
  	it "should have content 'About Around You & Me'" do
  		visit about_path
  		expect(page).to have_content('About Around You & Me')
  	end	
  end
 

end
