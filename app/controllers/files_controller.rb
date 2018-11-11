# frozen_string_literal: true

class FilesController < ApplicationController
  def create
    name = params[:name]
    tags = params[:tags]

    repository = FileResourceRepository.new
    file_resource = repository.create(name: name, tags: tags)

    render json: { uuid: file_resource.id }, status: 201
  end

  def search
    tag_search_query = params[:tag_search_query]
    page = params[:page].to_i

    service = FileResourceService.new
    search_response = service.search_by_tag(tag_search_query, page)

    files_search_resource = FilesSearchResource.new(
      search_response: search_response,
      search_query: tag_search_query
    )

    render json: files_search_resource.to_hash
  end
end
