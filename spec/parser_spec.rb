# -*- coding: utf-8 -*-

require 'date'

require './lib/parser'

def forecast_factory(min, max)
  (0...5).map do |i|
    f_min = rand(min)
    f_max = 0
    prec  = rand(41)
    prob  = rand(100)

    f_max = rand(max) while f_max < f_min

    Forecast.new DateTime.now + i, "#{f_min}ºC", "#{f_max}ºC",
                 "#{prec}mm", "#{prob}%", "Sol #{i}"
  end
end

include ClimaTempo

describe Parser do
  before :each do
    @places = { 'brasilia/df'     => forecast_factory(24, 33),
                'riodejaneiro/rj' => forecast_factory(29, 41) } 
  end
  
  it "has forecasts for Rio de Janeiro and Brasília" do
    ClimaTempo::Parser.should_receive(:parse).with("").and_return @places
    parsed = ClimaTempo::Parser.parse("")

    parsed.should include('brasilia/df', 'riodejaneiro/rj')
  end

  it "has five forecasts for every place" do
    ClimaTempo::Parser.should_receive(:parse).with("").and_return @places
    parsed = ClimaTempo::Parser.parse("")

    parsed.all? { |p, forecast|
      forecast.size == 5
    }.should be_true
  end
end
