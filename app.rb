require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

get '/' do
  erb :index
end
