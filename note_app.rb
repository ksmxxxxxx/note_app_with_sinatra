require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'slim'
require 'securerandom'
require './note.rb'

get '/' do
  @title = 'Note'
  @content = 'Note List'
  files = Dir.glob("data/*.json").sort_by { |file| File.mtime(file) }.reverse
  @notes = files.map { |file| JSON.parse(File.read(file), symbolize_names: true) }

  slim :index
end

get '/new' do
  @title = 'Add new note'

  slim :new
end

post '/new' do
  Note.create(title: params[:title], body: params[:body])

  redirect to('/')
end

get '/notes/:uuid' do
  @note = Note.get_by_id(uuid: params[:uuid])

  slim :show
end

get '/notes/:uuid/edit' do
  @note = Note.get_by_id(uuid: params[:uuid])

  slim :edit
end

put '/notes/:uuid' do
  Note.edit(uuid: params[:uuid], title: params[:title], body: params[:body])

  redirect to('/')
end

delete '/notes/:uuid' do
  Note.delete(uuid: params[:uuid])

  redirect to('/')
end
