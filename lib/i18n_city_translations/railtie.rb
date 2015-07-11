require 'rails'

module I18nCityTranslations
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'i18n-city-translations' do |app|
      I18nCityTranslations::Railtie.instance_eval do
        pattern = pattern_from app.config.i18n.available_locales

        add("rails/locale/**/#{pattern}.yml")
      end
    end

    def self.add(pattern)
      files = Dir[File.join(File.dirname(__FILE__), '../..', pattern)]
      I18n.load_path.concat(files)
    end

    def self.pattern_from(args)
      array = Array(args || [])
      array.blank? ? '*' : "{#{array.join ','}}"
    end
  end
end
