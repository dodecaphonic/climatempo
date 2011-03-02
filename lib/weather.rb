# -*- coding: utf-8 -*-
require "parser"
require "open-uri"

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
  
  class Weather
    attr_reader :places, :capitals, :brazil,
                :regions, :airports

    def initialize
      @capitals = load_up(:capitals)
      @brazil   = load_up(:brazil)
      @regions  = load_up(:regions)
      @airports = load_up(:airports)

      @places = @capitals.merge(@brazil).
        merge(@regions).merge(@airports)
    end

    def forecast_for(place)
      @places[place] || @places[CAPITALS[place]]
    end

    private
    def load_up(feed)
      Parser.parse open(SOURCES[feed]), feed
    end
  end
end
