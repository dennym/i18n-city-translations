require 'rubygems'
require 'open-uri'
require 'i18n_city_translations/import_locode'

desc 'Import city codes and names from un/locode.'
task :city_import do
  import = I18nCityTranslations::ImportLocode.new(ENV['IMPORT_LOCALE'])
  import.process
end

desc 'Translates the locale files'
task :city_translate do
  begin
    require 'nokogiri'
  rescue LoadError
    puts 'Error: Nokogiri library required to use this task (import:city_import)'
    exit
  end

  import = I18nCityTranslations::TranslateCity.new(ENV['IMPORT_LOCALE'])
  import.process
end
