# frozen_string_literal: true

require 'yaml'
require 'csv'
require 'pathname'

module I18nCityTranslations
  class TranslateCity
    attr_accessor :output_dir
    attr_reader :locales

    GEONAMES_ALTERNATE_NAMES_COL_NAME = %i[
      alternate_name_id
      geonameid
      isolanguage
      alternate_name
      is_preferred_name
      is_short_name
      is_colloquial
      is_historic
    ].freeze
    CSV_OPTIONS = {
      col_sep: "\t",
      headers: GEONAMES_ALTERNATE_NAMES_COL_NAME
    }.freeze
    FILE_PATH = 'tmp/alternateNames.txt'

    def initialize(locale = nil)
      @locale = locale
      @logger = Logging.logger(STDOUT)
      @geonames_locodes = Hash[geonames_locodes]
      @geonames_alternante_names = Hash[geonames_alternante_names]
    end

    def process
      file = "rails/locale/iso_639-1/#{@locale}.yml"
      data = YAML.load_file(file)
      data[@locale]['cities'].keys.each do |un_locode|
        translated = translation(un_locode)
        data[@locale]['cities'][un_locode] = translated if translated
      end

      save_changes(data, file)
    end

    private

    def save_changes(data, file)
      File.open(file, 'w') do |h|
        h.write data.to_yaml
      end
    end

    def translation(un_locode)
      geoname_id = @geonames_locodes[un_locode]
      return @geonames_alternante_names[geoname_id] if geoname_id
    end

    def geonames_alternante_names
      fetch(@locale)
        .select { |row| row[:isolanguage] == @locale }
        .map    { |row| [row[:geonameid], row[:alternate_name]] }
    end

    def geonames_locodes
      fetch('unlc')
        .select { |row| row[:isolanguage] == 'unlc' }
        .map    { |row| [row[:alternate_name], row[:geonameid]] }
    end

    def fetch(word)
      output = `grep -w "#{word}" #{FILE_PATH}`
      output = output.tr('"', "'") # there are both " and ' in geonames file
      CSV.parse(output, CSV_OPTIONS)
    end
  end
end
