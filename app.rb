require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'
require 'google/cloud/storage'

storage = Google::Cloud::Storage.new(
  credentials: "./credentials.json"
)

bucket = storage.bucket "gcs-sample-posts"

get '/' do
  erb :index
end
