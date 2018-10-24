require 'open-uri'
require 'zip'
require 'csv'
require 'logging'
require 'fileutils'

module I18nCityTranslations
  class ImportGeonames
    EXPORT_FILE = 'http://download.geonames.org/export/dump/alternateNames.zip'
    EXPORT_DIRECTORY = 'tmp'

    def initialize(locale = nil)
      @locale = locale
      @logger = Logging.logger(STDOUT)
    end

    def process
      download_archive
      extract_file
    end

    private

    def download_archive
      FileUtils.mkdir_p(EXPORT_DIRECTORY)
      File.open(EXPORT_DIRECTORY.to_s + '/geonames_export.zip', 'wb') do |f|
        open(EXPORT_FILE, 'rb') do |export|
          f.write export.read
          @logger.info '--- File downloaded ---'
        end
      end
    end

    def extract_file
      Zip::File.open(EXPORT_DIRECTORY.to_s + '/geonames_export.zip') do |zip_file|
        zip_file.each do |f|
          f_path = File.join(EXPORT_DIRECTORY, f.name)
          zip_file.extract(f, f_path)
        end
      end
      @logger.info '--- File extracted ---'
    end
  end
end
