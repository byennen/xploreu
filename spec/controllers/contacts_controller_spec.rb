require File.dirname(__FILE__) + '/../spec_helper'

class MockContact
  attr_accessor :name, :email, :phone, :message
end

describe ContactsController do
  before(:each) do
    @contact = MockContact.new
    Contact.stub!(:new).and_return(@contact)
  end
  describe "on GET to new" do
    it "should create contact for form" do
      Contact.should_receive(:new).and_return(@contact)
      get :new
    end
    it "should assign contact to form" do
      get :new
      assigns(:contact).should == @contact
    end
  end
  describe "on POST to create" do
    it "should check validity of contact" do
      @contact.should_receive(:valid?)
      post :create
    end
    it "should populate contact with form data" do;
      @contact.stub!(:valid?)
      params = { :name     => "Lance",
                 :email    => "lance@example.com",
                 :phone    => "555-555-1234",
                 :message  => "Hello"
               }
      post :create, params
      @contact.name.should    == params[:name] 
      @contact.email.should   == params[:email]
      @contact.phone.should   == params[:phone]
      @contact.message.should == params[:message]
    end
    describe "with valid contact" do
      before(:each) do
        @contact.stub!(:valid?).and_return(true)
        @contact.stub!(:deliver)
      end
      it "should deliver the contact" do
        @contact.should_receive(:deliver)
        post :create
      end
      it "should notify the user of successful submission" do
        post :create
        flash[:notice].should_not be_nil
      end
      it "should redirect the user to the home page" do
        post :create
        response.should redirect_to('/')
      end
    end
    describe "with invalid contact" do
      before(:each) do
        @contact.stub!(:valid?).and_return(false)
      end
      it "should render the contact form again" do
        post :create
        response.should render_template('contacts/new')
      end
    end
  end
end