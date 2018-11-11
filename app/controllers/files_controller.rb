# frozen_string_literal: true

class FilesController < ApplicationController
  def create
    name = params[:name]
    tags = params[:tags]

    repository = FileResourceRepository.new
    file_resource = repository.create(name: name, tags: tags)

    render json: { uuid: file_resource.id }, status: 201
  end
end
