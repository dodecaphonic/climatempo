# -*- coding: utf-8 -*-

require "date"

require "./spec/spec_helper"
require "./lib/parser"

include ClimaTempo

describe Parser do
  before :each do
    @capitals = { "brasilia/df"     => Factory.forecast_factory(24, 33),
                  "riodejaneiro/rj" => Factory.forecast_factory(29, 41) }

    @regions  = { "Sudeste" => Factory.descriptive_forecast_factory,
                  "Sul" => Factory.descriptive_forecast_factory,
                  "Norte" => Factory.descriptive_forecast_factory,
                  "Nordeste" => Factory.descriptive_forecast_factory,
                  "Centro-Oeste" => Factory.descriptive_forecast_factory }

    @airports = { "Conceição do Araguaia" => Factory.airport_factory,
                  "Aeroporto Iauaretê" => Factory.airport_factory }
  end

  it "has forecasts for Rio de Janeiro and Brasília" do
    ClimaTempo::Parser.should_receive(:parse).with("").and_return @capitals
    parsed = ClimaTempo::Parser.parse("")

    parsed.should include("brasilia/df", "riodejaneiro/rj")
  end

  it "has five forecasts for every place" do
    ClimaTempo::Parser.should_receive(:parse).with("").and_return @capitals
    parsed = ClimaTempo::Parser.parse("")

    parsed.all? { |p, forecast|
      forecast.size == 5
    }.should be_true
  end

  it "returns data for five regions" do
    ClimaTempo::Parser.should_receive(:parse).with("", :regions).and_return @regions
    parsed = ClimaTempo::Parser.parse("", :regions)

    parsed.size.should equal(5)
  end

  it "parses airports and assures us, very knowingly, that there's only one forecast per place" do
    ClimaTempo::Parser.should_receive(:parse).with("", :airports).and_return @airports

    parsed = ClimaTempo::Parser.parse("", :airports)
    parsed.all? { |p, forecasts| forecasts.size == 1 }.should be_true
  end
end
