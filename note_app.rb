require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'slim'
require 'securerandom'
require './note.rb'

get '/' do
  @title = 'Note'
  @notes = Note.render

  slim :index
end

get '/notes/new' do
  @title = 'Add new note'

  slim :new
end

post '/notes' do
  Note.create(title: params[:title], body: params[:body])

  redirect to('/')
end

get '/notes/:id' do
  @note = Note.get_by_id(id: params[:id])

  slim :show
end

get '/notes/:id/edit' do
  @note = Note.get_by_id(id: params[:id])

  slim :edit
end

patch '/notes/:id' do
  Note.edit(id: params[:id], title: params[:title], body: params[:body])

  redirect to('/')
end

delete '/notes/:id' do
  Note.delete(id: params[:id])

  redirect to('/')
end

not_found do
  slim :not_found, :layout => false
end
