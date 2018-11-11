# frozen_string_literal: true

class FileResourceRepository
  include Elasticsearch::Persistence::Repository

  def initialize(model = FileResource)
    @options = {
      client: Elasticsearch::Client.new(host: ENV['ELASTICSEARCH_HOST'], port: ENV['ELASTICSEARCH_PORT']),
      index_name: :file_resource
    }
    @model = model
  end

  def create(attrs = {})
    file_resource = @model.new(attrs)
    save file_resource
    file_resource
  end

  def find_by_id(id)
    @model.new(find(id))
  end
end
