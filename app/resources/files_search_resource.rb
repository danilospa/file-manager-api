# frozen_string_literal: true

class FilesSearchResource
  include Virtus.model
  attribute :total_records
  attribute :related_tags
  attribute :records

  def initialize(search_response:, search_query:)
    @search_response = search_response
    @search_query = search_query
  end

  def total_records
    @search_response.total
  end

  def related_tags
    query_tags = SearchMethods.values_from_query(@search_query)
    tags_from_results = @search_response.results.flat_map { |r| r['tags'] }.uniq

    (tags_from_results - query_tags).map do |tag|
      {
        tag: tag,
        file_count: @search_response.results.count { |r| r['tags'].include?(tag) }
      }
    end
  end

  def records
    @search_response.results.map { |r| { uuid: r['id'], name: r['name'] } }
  end
end
