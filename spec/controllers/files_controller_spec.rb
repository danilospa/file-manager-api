# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  let(:body) { JSON.parse(response.body, symbolize_names: true) }
  let(:repository) { FileResourceRepository.new }

  describe '#create' do
    before do
      post :create, params: { name: 'file name', tags: %w[tag1 tag2] }
    end

    after do
      repository.delete_index!
    end

    it 'returns correct status code' do
      expect(response.status).to eq 201
    end

    it 'creates file resource with correct name and tags' do
      uuid = body[:uuid]
      expect(repository.find_by_id(uuid).to_hash).to include(
        name: 'file name',
        tags: %w[tag1 tag2]
      )
    end
  end

  describe '#search' do
    let(:tag1) { 'tag1' }
    let(:tag2) { 'tag2' }
    let(:tag3) { 'tag3' }
    let(:tag4) { 'tag4' }
    let!(:file_resource1) { repository.create(name: 'filename1', tags: [tag1, tag2, tag4]) }
    let!(:file_resource2) { repository.create(name: 'filename2', tags: [tag1, tag2, tag3]) }
    let!(:file_resource3) { repository.create(name: 'filename3', tags: [tag2, tag3]) }

    before do
      repository.client.indices.flush(index: repository.index_name)

      get :search, params: { tag_search_query: "+#{tag1} +#{tag2} -#{tag3}", page: 1 }
    end
    after do
      repository.delete_index!
    end

    it 'returns correct status code' do
      expect(response.status).to eq 200
    end

    it 'returns records matching the search query' do
      expect(body[:records]).to eq [
        { uuid: file_resource1.id, name: file_resource1.name }
      ]
    end

    it 'returns number os records matching the search query' do
      expect(body[:total_records]).to eq 1
    end

    it 'returns related tags' do
      expect(body[:related_tags]).to eq [{ tag: tag4, file_count: 1 }]
    end
  end
end
