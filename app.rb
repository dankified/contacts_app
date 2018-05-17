require 'rubygems'
require 'bundler'
Bundler.require

include Humanity

get '/contacts' do
  content_type :json
  people = Person.all
  people.map{ |person| person.attributes }.to_json
end

get '/contacts/:id' do
  begin
    person = Person.find(params[:id])
    content_type :json
    person.attributes.to_json
  rescue
    status 404
  end
end

post '/contacts' do
  content_type :json
  begin
    person = Person.new(params)
    person.save
    status 201
    person.attributes.to_json
  rescue
    status 422
  end
end

delete '/contacts/:id' do
  content_type :json
  begin
    person = Person.find(params[:id])
    person.delete
    status 204
  rescue
    status 422
  end
end

put '/contacts/:id' do
  content_type :json
  begin
    person = Person.find(params[:id])
    person.send("#{params[:field]}=", params[:value])
    person.save
    person.attributes.to_json
  rescue
    status 422
  end
end
