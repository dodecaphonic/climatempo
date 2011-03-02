# -*- coding: utf-8 -*-

require './lib/parser'

describe "ClimaTempo weather forecast parser" do
  before(:all) do
    @basedir  = File.dirname(__FILE__)
    @capitals = "http://www.climatempo.com.br/rss/capitais.xml"
    @airports = "http://www.climatempo.com.br/rss/aeroportos.xml"
    @regions = "http://www.climatempo.com.br/rss/regioes.xml"
  end

  it "has forecasts for Rio de Janeiro and Brasília" do
    parsed = ClimaTempo::Parser.parse(open(@capitals))

    parsed.should include('brasilia/df', 'riodejaneiro/rj')
  end


  it "extracts places from a given feed" do
    parsed = ClimaTempo::Parser.parse(open(@capitals))

    parsed.should_not be_empty
  end

  it "extracts five forecasts for any given place in a feed" do
    parsed = ClimaTempo::Parser.parse(open(@capitals))

    parsed.all? { |pl, forecasts| forecasts.size == 5 }.should be_true
  end

  it "knows airports only have forecasts for a single day" do
    parsed = ClimaTempo::Parser.parse(open(@airports), :airports)

    parsed.all? { |pl, forecasts| forecasts.size == 1 }.should be_true
  end
end
