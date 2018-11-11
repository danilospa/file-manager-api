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
end
