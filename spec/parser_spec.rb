# -*- coding: utf-8 -*-

require "date"

require "./lib/parser"

def forecast_factory(min, max)
  (0...5).map do |i|
    f_min = rand(min)
    f_max = 0
    prec  = rand(41)
    prob  = rand(100)

    f_max = rand(max) while f_max < f_min

    Forecast.new DateTime.now + i, :min => "#{f_min}ºC",
                 :max => "#{f_max}ºC", :precipitation => "#{prec}mm", 
                 :probability => "#{prob}%", :conditions => "Sol #{i}"
  end
end

def region_forecast_factory
  (0...5).map { |i|
    Forecast.new DateTime.now + i, :conditions => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a scelerisque justo. Sed mauris augue, accumsan nec pellentesque faucibus, ullamcorper sed metus. In sit amet risus velit. Aenean semper odio eget tortor laoreet viverra. Nam semper, nibh in auctor porttitor, eros velit pellentesque erat, sed iaculis arcu turpis eu lorem."
  }
end

include ClimaTempo

describe Parser do
  before :each do
    @capitals = { "brasilia/df"     => forecast_factory(24, 33),
                  "riodejaneiro/rj" => forecast_factory(29, 41) } 

    @regions  = { "Sudeste" => region_forecast_factory,
                  "Sul" => region_forecast_factory,
                  "Norte" => region_forecast_factory,
                  "Nordeste" => region_forecast_factory,
                  "Centro-Oeste" => region_forecast_factory }

    @airports = { "Conceição do Araguaia" => [Forecast.new(DateTime.now, :now => "23ºC", :conditions => "Muitas nuvens.", :humidity => "71%", :pressure => "1341 hPa")],
                  "Aeroporto Iauaretê" => [Forecast.new(DateTime.now, :now => "###ºC", :conditions => "Sol.", :humidity => "###%", :pressure => "ND hPa")] }
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
