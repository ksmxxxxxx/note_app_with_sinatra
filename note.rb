require 'json'
require 'securerandom'
require 'pg'

class Note
  @connection = PG.connect( dbname: 'note_app' )
  order_by_id_desc = "SELECT * FROM note ORDER BY id DESC"
  get_by_id = "SELECT * FROM note WHERE id=$1"
  create = "INSERT INTO note(title, body) VALUES ($1, $2)"
  edit = "UPDATE note SET title=$1, body=$2 WHERE id=$3"
  delete = "DELETE FROM note WHERE id=$1"

  @connection.prepare('render', order_by_id_desc)
  @connection.prepare('get_by_id', get_by_id)
  @connection.prepare('create', create)
  @connection.prepare('edit', edit)
  @connection.prepare('delete', delete)

  class << self
    def render
      @connection.exec_prepared( 'render' )
    end

    def get_by_id(id: note_id)
      @connection.exec_prepared( 'get_by_id', [id] )
    end

    def create(title: note_title, body: note_body)
      @connection.exec_prepared( 'create', [title, body] )
    end

    def edit(id: note_id, title: note_title, body: note_body)
      @connection.exec_prepared( 'edit', [title, body, id] )
    end

    def delete(id: note_uuid)
      @connection.exec_prepared( 'delete', [id] )
    end
  end
end
