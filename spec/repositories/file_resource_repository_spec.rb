# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileResourceRepository, type: :repository do
  let(:model) { double('FileResource') }
  subject { described_class.new(model) }

  describe '#create' do
    before do
      allow(subject).to receive(:save)
      allow(model).to receive(:new).and_return('model instance')
    end

    it 'instanciates object with given attrs' do
      expect(model).to receive(:new).with('attrs')
      subject.create('attrs')
    end

    it 'saves object with new instance of model' do
      expect(subject).to receive(:save).with('model instance')
      subject.create
    end

    it 'returns model instance' do
      expect(subject.create).to eq 'model instance'
    end
  end
end
