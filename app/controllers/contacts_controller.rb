class ContactsController < ApplicationController
  layout  'site'
  
  def new
    @contact = Contact.new
    @title = "Contact"  
  end
  
  def create
    debugger
    @contact = Contact.create params[:contact]
    if @contact.valid?
      @contact.deliver
      flash[:notice] = "Contact Message Sent"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
end
