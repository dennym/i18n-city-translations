require 'i18n_city_translations'
require 'i18n_city_translations/railtie'

module I18nCityTranslations
  def self.root
    File.expand_path('../..', __FILE__)
  end
end
