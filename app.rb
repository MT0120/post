require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'
enable :sessions
helpers do
    def current_user
      User.find_by(id: session[:user])
    end    
end

get '/' do
    if current_user.nil?
        @posts = Post.none
    else
        @posts = Post.all
    end    
  erb :index
end

get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/posts/new' do
    erb :new
end

post  '/posts' do
    current_user.posts.create(body: params[:title])
    redirect '/'
end

post '/posts/:id/delete' do
    post = Post.find(params[:id])
    post.destroy
    redirect '/'
end