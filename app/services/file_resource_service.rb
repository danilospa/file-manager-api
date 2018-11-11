# frozen_string_literal: true

class FileResourceService
  include SearchMethods
  DEFAULT_PAGE_SIZE = 10

  def initialize(repository: FileResourceRepository.new)
    @repository = repository
  end

  def search_by_tag(tag_search_query, page)
    @repository.search(
      query: {
        bool: {
          must: must_terms('tags', tag_search_query),
          must_not: must_not_terms('tags', tag_search_query)
        }
      },
      size: DEFAULT_PAGE_SIZE,
      from: DEFAULT_PAGE_SIZE * (page - 1)
    )
  rescue Elasticsearch::Transport::Transport::Errors::NotFound
    OpenStruct.new(
      total: 0,
      results: []
    )
  end
end
