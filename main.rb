require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'

#set :database, "sqlite3:sinatra_form.sqlite3"
configure(:development){set :database, "sqlite:///blog.sqlite3"}

enable :sessions
use Rack::Flash, :sweep => true
set :sessions => true

def current_user
  if session[:user_id]
     @current_user = User.find(session[:user_id])
  end
end



get '/' do
  erb :index
end

get '/goodbye' do
  erb :goodbye
end
post '/sign-in' do
  puts "my params are " + params.inspect
  @user = User.where(params[:user]).first
  #puts "************************"
  #puts params[:user][:password]
  if @user.password == params[:user][:password]
    flash[:notice] = "#{params[:user][:fname]} has been signed in successfully"
    session[:user_id] = @user.id
    redirect '/'
  else
    flash[:notice] = "There was a problem signing you in."
    redirect '/'
  end
end

# get '/session' do
#   session[:name] = "Brown"
#   "Hello"
# end

# get '/value' do
#   "The name of this " + session[:name]
# end

post '/sign-out' do
  puts session[:user_id]
  session.clear
  puts session[:user_id]
  redirect '/goodbye'
end

get '/sign-out' do
  puts "This user is here " + session[:user_id].to_s
end


