require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'slim'
require 'securerandom'
require './note.rb'

get '/' do
  @title = 'Note'
  @content = 'Note List'
  @notes = Note.render_note

  slim :index
end

get '/notes/new' do
  @title = 'Add new note'

  slim :new
end

post '/notes/new' do
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

not_found do
  slim :not_found, :layout => false
end
