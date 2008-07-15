class ContactsController < ApplicationController
  layout  'site'
  
  def new
    @title = "Contact"
    @contact = Contact.new  
  end
  
  def create
    @title = "Contact" 
    @contact = Contact.new params[:contact]
    if @contact.valid?
      @contact.deliver
      flash[:notice] = "Contact Message Sent"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
end
