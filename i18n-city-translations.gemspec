$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'i18n_city_translations/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name         = 'i18n-city-translations'
  s.version      = I18nCityTranslations::VERSION
  s.authors      = ['Denny Mueller']
  s.email        = ['denny@dennymueller.de']
  s.homepage     = 'https://github.com/dennym/i18n-city-translations'
  s.summary      = 'I18n City Translations'
  s.description  = 'The purpose of this gem is to simply provide city translations.
                    The gem is intended to be easy to combine with other gems that require
                    i18n city translations so we can have common i18n city translation gem.'

  s.files        = Dir.glob('lib/**/*') + Dir.glob('rails/locale/**/*') + %w(README MIT-LICENSE)
  s.test_files   = Dir['test/**/*']
  s.require_path = 'lib'
  s.platform     = Gem::Platform::RUBY

  s.add_dependency('i18n', '0.7.0')
  s.add_dependency 'railties', '4.2.2'
  s.add_development_dependency 'rails', '4.2.2'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'i18n-spec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rubyzip'
  s.add_development_dependency 'logging'

  s.licenses = ['MIT', 'GPL-2']
end
