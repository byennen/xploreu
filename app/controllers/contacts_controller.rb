class ContactsController < ApplicationController
  before_filter :create_contact
  def new
    @title = "Contact"  
  end
  
  def create
    @contact.name = params[:name]
    @contact.email = params[:email]
    @contact.phone = params[:phone]
    @contact.message = params[:message]
    if @contact.valid?
      @contact.deliver
      flash[:notice] = "Contact Message Sent"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  private
  def create_contact
    @contact = Contact.new
  end
  
end
