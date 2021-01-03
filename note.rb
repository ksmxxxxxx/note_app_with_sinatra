require 'json'
require 'securerandom'
require 'pg'

class Note
  class << self
    def render_note
      connection = PG.connect( dbname: 'note_app' )
      connection.exec( "SELECT * FROM note" )
    end

    def get_by_id(id: note_id)
      connection = PG.connect( dbname: 'note_app' )
      connection.exec( "SELECT * FROM note WHERE id=#{id}" )
    end

    def create(title: note_title, body: note_body)
      connection = PG.connect( dbname: 'note_app' )
      connection.exec( "INSERT INTO note(title, body) VALUES ('#{title}', '#{body}')" )
    end

    def edit(id: note_id, title: note_title, body: note_body)
      connection = PG.connect( dbname: 'note_app' )
      connection.exec( "UPDATE note SET title='#{title}', body='#{body}' WHERE id=#{id}" )
    end

    def delete(id: note_uuid)
      connection = PG.connect( dbname: 'note_app' )
      connection.exec( "DELETE FROM note WHERE id=#{id}" )
      #File.delete("data/#{uuid}.json")
    end
  end
end
