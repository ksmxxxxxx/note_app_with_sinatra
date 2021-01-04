require 'json'
require 'securerandom'

class Note
  class << self
    def render_note
      files = Dir.glob("data/*.json").sort_by { |file| File.mtime(file) }.reverse
      files.map { |file| JSON.parse(File.read(file), symbolize_names: true) }
    end

    def get_by_id(uuid: note_id)
      JSON.parse(File.read("data/#{uuid}.json"), symbolize_names: true)
    end

    def create(title: note_title, body: note_body)
      note_data = { uuid: SecureRandom.uuid, title: title, body: body }
      File.open("data/#{note_data[:uuid]}.json", "w") do |file|
        file.puts JSON.pretty_generate(note_data)
      end
    end

    def edit(uuid: note_uuid, title: note_title, body: note_body)
      note_data = { uuid: uuid, title: title, body: body }
      File.open("data/#{note_data[:uuid]}.json", "w") do |file|
        file.puts JSON.pretty_generate(note_data)
      end
    end

    def delete(uuid: note_uuid)
      File.delete("data/#{uuid}.json")
    end
  end
end
