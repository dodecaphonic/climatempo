# -*- coding: utf-8 -*-
module ClimaTempo
  SOURCES = {
    :capitals => "http://www.climatempo.com.br/rss/capitais.xml",
    :brazil => "http://www.climatempo.com.br/rss/brasil.xml",
    :regions => "http://www.climatempo.com.br/rss/regioes.xml",
    :airports => "http://www.climatempo.com.br/rss/aeroportos.xml"
  }.freeze

  CAPITALS = {
    "Rio Branco" => "riobranco/ac",
    "Maceió" => "maceio/al",
    "Macapá" => "macapa/ap",
    "Manaus" => "manaus/am",
    "Salvador" => "salvador/ba",
    "Fortaleza" => "fortaleza/ce",
    "Brasília" => "brasilia/df",
    "Espírito Santo" => "vitoria/es",
    "Goiânia" => "goiania/go",
    "São Luís" => "saoluis/ma",
    "Cuiabá" => "cuiaba/mt",
    "Campo Grande" => "campogrande/ms",
    "Belo Horizonte" => "belohorizonte/mg",
    "Belém" => "belem/pa",
    "João Pessoa" => "joaopessoa/pb",
    "Curitiba" => "curitiba/pr",
    "Recife" => "recife/pe",
    "Teresina" => "teresina/pi",
    "Rio de Janeiro" => "riodejaneiro/rj",
    "Porto Alegre" => "portoalegre/rs",
    "Natal" => "natal/rn",
    "Porto Velho" => "portovelho/ro",
    "Boa Vista" => "boavista/rr",
    "Florianópolis" => "florianopolis/sc",
    "São Paulo" => "saopaulo/sp",
    "Aracaju" => "aracaju/se",
    "Palmas" => "palmas/to"
  }

  class UnknownLocationError < StandardError; end

  class Weather
    attr_reader :places, :capitals, :brazil, :regions, :airports, :parser, :fetcher

    def initialize(capitals_only = false, fetcher = HTTParty, parser = Parser)
      @fetcher  = fetcher
      @parser   = parser
      @capitals = load_up(:capitals)

      unless capitals_only
        @brazil   = load_up(:brazil)
        @regions  = load_up(:regions)
        @airports = load_up(:airports)
      else
        @brazil   = {}
        @regions  = {}
        @airports = {}
      end

      @places = @capitals.merge(@brazil).
        merge(@regions).merge(@airports)
    end

    # Search nominally for a given place and
    # return its forecasts. Capital cities can be
    # found both by ClimaTempo's naming conventions
    # (no spaces, state at the end separated by a slash)
    # and their capitalized names.
    def forecast_for(place)
      @places[place] || @places.fetch(CAPITALS[place])
    rescue
      raise UnknownLocationError, "Couldn't find #{place} among the forecasts"
    end

    private
    def load_up(feed)
      parser.parse fetcher.get(SOURCES[feed]).body, feed
    end
  end
end
