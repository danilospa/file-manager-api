# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchMethods, type: :util do
  let(:klass) do
    class Klass
      include SearchMethods
    end
  end

  subject { klass.new }

  describe '.values_from_query' do
    it 'returns array os value without operator' do
      query = '+value -other-value'
      expect(described_class.values_from_query(query)).to eq ['value', 'other-value']
    end
  end

  describe '#must_terms' do
    let(:field) { 'field' }
    let(:query) { 'query' }
    before do
      allow(subject).to receive(:parse_terms).and_return('parsed terms')
    end

    it 'parse terms for given field and query and with + operator' do
      expect(subject).to receive(:parse_terms).with(field, query, '+')
      subject.must_terms(field, query)
    end

    it 'returns parsed terms' do
      expect(subject.must_terms(field, query)).to eq 'parsed terms'
    end
  end

  describe '#must_not_terms' do
    let(:field) { 'field' }
    let(:query) { 'query' }
    before do
      allow(subject).to receive(:parse_terms).and_return('parsed terms')
    end

    it 'parse terms for given field and query and with - operator' do
      expect(subject).to receive(:parse_terms).with(field, query, '-')
      subject.must_not_terms(field, query)
    end

    it 'returns parsed terms' do
      expect(subject.must_not_terms(field, query)).to eq 'parsed terms'
    end
  end

  describe '#parse_terms' do
    before do
      allow(subject).to receive(:term).and_return('value as term')
    end

    it 'calls term for each value with specified operator' do
      expect(subject).to receive(:term).with('tags', 'value')
      subject.parse_terms('tags', '+value -other-value', '+')
    end

    it 'returns terms' do
      expect(subject.parse_terms('tags', '+value -other-value', '+')).to eq ['value as term']
    end
  end

  describe '#term' do
    it 'returns term hash for given field and value' do
      expect(subject.term('field', 'value')).to eq term: { 'field' => 'value' }
    end
  end
end
