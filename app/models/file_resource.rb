# frozen_string_literal: true

require 'virtus'

class FileResource
  include Virtus.model

  def initialize(attrs = {})
    @id = SecureRandom.uuid
    super
  end

  attribute :id, String
  attribute :name, String
  attribute :tags, Array
end
