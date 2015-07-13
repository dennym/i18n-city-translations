require 'yaml'
require 'open-uri'
require 'zip'
require 'csv'
require 'logging'

module I18nCityTranslations
  class ImportLocode
    EXPORT_FILE = 'http://www.unece.org/fileadmin/DAM/cefact/locode/loc151csv.zip'
    EXPORT_DIRECTORY = 'tmp'

    def initialize(locale = nil)
      @locale = locale
      @logger = Logging.logger(STDOUT)
    end

    def process
      download_archive
      extract_file

      filename = File.join("#{file_location}", "#{@locale}.yml")
      File.rename(filename, filename + '.OLD') if File.exist?(filename) # Rename by appending 'OLD' if file exists

      File.open(filename, 'a') { |f| f << { @locale => { 'cities' => cities } }.to_yaml }

      FileUtils.rm_rf('tmp/.')
    end

    private

    def download_archive
      File.open(EXPORT_DIRECTORY.to_s + '/export.zip', 'wb') do |f|
        open(EXPORT_FILE, 'rb') do |export|
          f.write export.read
          @logger.info '--- File downloaded ---'
        end
      end
    end

    def extract_file
      Zip::File.open(EXPORT_DIRECTORY.to_s + '/export.zip') do |zip_file|
        zip_file.each do |f|
          f_path = File.join(EXPORT_DIRECTORY, f.name)
          zip_file.extract(f, f_path) if f.name =~ /.CodelistPart[0-9]\.csv$/i
        end
      end
      @logger.info '--- File extracted ---'
    end

    def read_files
      Dir['tmp/*CodeListPart*.csv'].sort
    end

    def cities
      cities = {}
      read_files.each do |file|
        @logger.info "--- Read and write from #{file} ---"
        CSV.foreach(file, encoding: 'ISO-8859-1') do |row|
          cities[row[1] + row[2]] = row[3] unless row[2].nil? || row[0] == '='
        end
      end

      cities
    end

    def file_location
      File.join(File.dirname(__FILE__), '..', '..', 'rails', 'locale', 'iso_639-1')
    end
  end
end
