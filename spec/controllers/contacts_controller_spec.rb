require File.dirname(__FILE__) + '/../spec_helper'

describe ContactsController do
  def mock_contact(params={})
    params = {:deliver => true, :save => true, :valid? => true}.merge(params)
    @mock_contact ||= mock_model(Contact, params)
  end
  
  describe "on GET to new" do
    it "should expose new contact as @contact" do
      Contact.should_receive(:new).and_return(@contact)
      get :new
      assigns(:contact).should == @contact
    end
  end

  describe "on POST to create" do
    it "should populate new contact with form data" do
      Contact.should_receive(:new).with({'these' => 'options'}).and_return(mock_contact)
      post :create, :contact => {'these' => 'options'}
    end

    describe "with valid contact" do
      it "should tell the contact to deliver" do
        Contact.should_receive(:new).and_return(mock_contact(:save => true))
        mock_contact.should_receive(:deliver)
        post :create
      end
      
      it "should notify the user of successful submission" do
        Contact.should_receive(:new).and_return(mock_contact(:save => true))
        post :create
        flash[:notice].should == "Contact Message Sent"
      end
      
      it "should redirect the user to the home page" do
        Contact.should_receive(:new).and_return(mock_contact(:save => true))
        post :create
        response.should redirect_to('/')
      end
    end
    
    describe "with invalid contact" do
      it "should render the new contact form again" do
        Contact.stub!(:new).and_return(mock_contact(:valid? => false))
        post :create
        response.should render_template('contacts/new')
      end
    end
  end
end