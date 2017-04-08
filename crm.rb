# Implement the new web-based CRM here.
# Do NOT copy the CRM class from the old crm assignment, as it won't work at all for the web-based version!
# You'll have to implement it from scratch.
require_relative 'contact'
require 'sinatra'
require 'pry'

get '/' do
  @crm_app_name = "PAUL CRM"
  # @contacts = Contact.all
  erb :index
end

get '/contacts' do
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  Contact.create(params[:first_name], params[:last_name], params[:email], params[:note])
  redirect to('/contacts')
end

get '/contacts/:id/delete' do
  contact_id = params["id"]
  contact = Contact.find(contact_id.to_i)
  contact.delete
  redirect to('/contacts')
end

get '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/contacts/:id/edit' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contacts/:id' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end


Contact.create("Paul", "Lam", "paullamx@gmail.com","Loves biking")
Contact.create("Harpreet", "Sehmbi", "harpreet@gmail.com","Comedian")
Contact.create("Kevin", "Liu", "liuke@gmail.com","Vita Mixer")
Contact.create("Evan", "Tran", "tanni@gmail.com","press 1")
Contact.create("Maple", "Lam", "maple@gmail.com","Casino Kween")
Contact.create("Henry", "Lam", "henry@gmail.com","Ping Pong King")
