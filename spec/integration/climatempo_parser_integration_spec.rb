# -*- coding: utf-8 -*-

require 'spec_helper'
require 'open-uri'

describe "ClimaTempo weather forecast parser" do
  let(:capitals) { 'http://www.climatempo.com.br/rss/capitais.xml' }
  let(:airports) { 'http://www.climatempo.com.br/rss/aeroportos.xml' }
  let(:regions) { 'http://www.climatempo.com.br/rss/regioes.xml' }

  it "has forecasts for Rio de Janeiro and Brasília" do
    VCR.use_cassette('capitals') do
      parsed = ClimaTempo::Parser.parse(open(capitals))
      parsed.should include('brasilia/df', 'riodejaneiro/rj')
    end
  end


  it "extracts places from a given feed" do
    VCR.use_cassette('capitals') do
      parsed = ClimaTempo::Parser.parse(open(capitals))
      parsed.should_not be_empty
    end
  end

  it "extracts five forecasts for any given place in a feed" do
    VCR.use_cassette('capitals') do
      parsed = ClimaTempo::Parser.parse(open(capitals))
      parsed.all? { |pl, forecasts| forecasts.size == 5 }.should be_true
    end
  end

  it "knows airports only have forecasts for a single day" do
    VCR.use_cassette('airports') do
      parsed = ClimaTempo::Parser.parse(open(airports), :airports)
      parsed.all? { |pl, forecasts| forecasts.size == 1 }.should be_true
    end
  end
end
