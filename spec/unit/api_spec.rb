# -*- coding: utf-8 -*-

require 'spec_helper'

describe ClimaTempo::Weather do
  let(:fetcher) { double('Fetcher') }
  let(:parser)  { double('Parser') }

  context 'capitals only' do
    subject { ClimaTempo::Weather.new(true, fetcher, parser) }

    before do
      fetcher.should_receive(:get).and_return(stub(body: ''))
      parser.should_receive(:parse).and_return({ 'brasilia/df' => [] })
    end

    describe '#forecast_for' do
      it do
        subject.forecast_for('Brasília').should_not be_nil
        subject.forecast_for('brasilia/df').should_not be_nil
      end

      it 'raises UnknownLocationError when a Location has not been found' do
        -> { subject.forecast_for('wonderland/wl') }.should raise_error(ClimaTempo::UnknownLocationError)
      end
    end
  end
end
