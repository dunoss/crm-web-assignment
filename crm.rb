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

get '/contacts/1' do
  @contact = Contact.find(1)
  erb :show_contact
end

Contact.create("Paul", "Lam", "paullamx@gmail.com","Loves biking")
Contact.create("Harpreet", "Sehmbi", "harpreet@gmail.com","Comedian")
Contact.create("Kevin", "Liu", "liuke@gmail.com","Vita Mixer")
Contact.create("Evan", "Tran", "tanni@gmail.com","press 1")
Contact.create("Maple", "Lam", "maple@gmail.com","Casino Kween")
Contact.create("Henry", "Lam", "henry@gmail.com","Ping Pong King")
