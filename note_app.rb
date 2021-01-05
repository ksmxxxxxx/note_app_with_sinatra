require 'sinatra'
require 'sinatra/reloader'
require 'json'
#require 'slim'
require 'erb'
require 'securerandom'
require './note.rb'
include ERB::Util

get '/' do
  @title = 'Note'
  @content = 'Note List'
  @notes = Note.render_note

  erb :index
end

get '/notes/new' do
  @title = 'Add new note'

  erb :new
end

post '/notes/new' do
  Note.create(title: params[:title], body: params[:body])

  redirect to('/')
end

get '/notes/:uuid' do
  @note = Note.get_by_id(uuid: params[:uuid])

  erb :show
end

get '/notes/:uuid/edit' do
  @note = Note.get_by_id(uuid: params[:uuid])

  erb :edit
end

patch '/notes/:uuid' do
  Note.edit(uuid: params[:uuid], title: params[:title], body: params[:body])

  redirect to('/')
end

delete '/notes/:uuid' do
  Note.delete(uuid: params[:uuid])

  redirect to('/')
end

not_found do
  erb :not_found, :layout => false
end

helpers do
  def h(text)
    escape_html(text)
  end
end
