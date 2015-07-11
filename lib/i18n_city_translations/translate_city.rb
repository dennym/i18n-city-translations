require 'yaml'
require 'open-uri'
require 'nokogiri'
# Imports ISO 639-1 country codes
# It parses a HTML file from Unicode.org for given locale and saves the
# Rails' I18n hash in the plugin +locale+ directory
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
