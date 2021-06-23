require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'
require 'google/cloud/storage'
require 'securerandom'

storage = Google::Cloud::Storage.new(
  credentials: "./credentials.json"
)

bucket = storage.bucket "gcs-sample-posts"

get '/' do
  @posts = Post.all
  erb :index
end

get '/file/:id' do
  data = Post.find(params[:id])
  file = bucket.file data.file
  redirect file.signed_url
end

post '/post' do
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    file = bucket.create_file tempfile.path, SecureRandom.uuid + File.extname(tempfile.path)
    Post.create(body: params[:body], file: file.name)
  end
  redirect '/'
end