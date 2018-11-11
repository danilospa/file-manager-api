# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HealthCheckController, type: :controller do
  describe '#index' do
    it 'returns correct status code' do
      get :index
      expect(response.status).to eq 200
    end
  end
end
