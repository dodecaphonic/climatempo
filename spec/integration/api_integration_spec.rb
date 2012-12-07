# -*- coding: utf-8 -*-

require 'spec_helper'

describe ClimaTempo::Weather do
  before :each do
    VCR.use_cassette('all_forecasts') do
      @weather = ClimaTempo::Weather.new
    end
  end

  it "lets us get forecast information for a specific place" do
    @weather.forecast_for("brasilia/df").should_not be_nil
  end

  it "allows us to use actual names for capitals instead of ClimaTempo's weirdly condensed versions" do
    @weather.forecast_for("Rio de Janeiro").should_not be_nil
  end
end
