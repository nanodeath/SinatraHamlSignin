require 'rubygems'
require 'sinatra'

use :sessions, true

helpers do
  def validate(username, password)
    # Put your real validation logic here
    return username == "max"
  end
  
  def is_logged_in?
    session["logged_in"] == true
  end
  
  def clear_session
    session.clear
  end
end

get '/' do
  haml :index
end

get '/login' do
  haml :login
end

post '/login' do
  if(validate(params["username"], params["password"]))
    session["logged_in"] = true
    session["username"] = params["username"]
    @message = "You've been logged in.  Welcome back, #{params["username"]}"
    haml :index
  else
    @errors = "Sorry, those credentials aren't valid."
    haml :login
  end
end

get '/logout' do
  clear_session
  @message = "You've been logged out."
  haml :index
end