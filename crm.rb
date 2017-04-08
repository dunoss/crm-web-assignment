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
  contact = Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end

# post '/contacts' do
#   Contact.create(
#   params[:first_name],
#   params[:last_name],
#   params[:email],
#   params[:note]
#   )
#   redirect to('/contacts')
# end

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
    @contact.update_attribute(:first_name, params[:first_name])
    @contact.update_attribute(:last_name, params[:last_name])
    @contact.update_attribute(:email, params[:email])
    @contact.update_attribute(:note, params[:note])

    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end
