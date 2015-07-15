require 'git'
require 'yaml'

module I18nCityTranslations
  class CreateLanguages
    def initialize
    end

    def process
      clone_repo

      folders = Dir.glob('rails/locale/*/').map { |f| f.split('/').last }

      folders.each do |folder|
        locales(folder).each do |locale|
          next if locale == 'en' || File.exist?("rails/locale/#{folder}/#{locale}.yml")
          FileUtils.cp('rails/locale/iso_639-1/en.yml', "rails/locale/#{folder}/" + "#{locale}.yml")

          file = "rails/locale/#{folder}/#{locale}.yml"
          data = YAML.load_file(file)

          change_language(data, file, locale)
        end
      end

      FileUtils.rm_rf('tmp/.')
    end

    def change_language(data, file, locale)
      data[locale] = data.delete('en')

      File.open(file, 'w') do |h|
        h.write data.to_yaml
      end
    end

    def clone_repo
      Git.clone('https://github.com/onomojo/i18n-country-translations.git', 'cloned_repo', path: 'tmp')
    end

    def locales(folder)
      locale_files = Dir.glob("tmp/cloned_repo/rails/locale/#{folder}" + '/*.yml')
      locale_files.map { |f| f.split('/').last.split('.')[0] }
    end
  end
end
