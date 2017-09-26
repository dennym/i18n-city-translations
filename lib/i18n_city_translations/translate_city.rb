require 'yaml'
require 'open-uri'
require 'nokogiri'

# http://api.geonames.org/search?name=moskva&country=RU&featureCode=PPLC&maxRows=10&type=rdf&username=demo
# http://download.geonames.org/export/dump/alternateNames.zip

module I18nCityTranslations
  class TranslateCity
    attr_accessor :output_dir
    attr_reader :locales

    def initialize
    end

    def process
    end
  end
end
