# I18nCityTranslations !!! WIP No correct translation available yet !!!

[![Build Status](https://travis-ci.org/dennym/i18n-city-translations.svg)](https://travis-ci.org/dennym/i18n-city-translations)

The purpose of this gem is to simply provide city translations.

If you're doing anything with city names and translations, there's no need to reinvent the wheel and add your own translations. Just use this gem's city translations and skip the hassle of having to add and manage each city translation for each locale.

## Supported Locales
Locales we will include are specified by ISO 639-1 alpha2, http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes

## Supported City Codes
City codes used are those specified in UN/Locode, http://www.unece.org/cefact/locode/service/location.html


## Installation

Add to your Gemfile:

    gem 'i18n-city-translations'

## Usage

    I18n.t(:DEBER, :scope => :cities)

or

    t(:DEBER, :scope => :cities)

## Contributing

The locales were generated using this rake task which you might find useful somehow:

    IMPORT_LOCALE=en rake import:city_import
    IMPORT_LOCALE=en rake import:city_translation

It will generate a new yml file that contains the all cities from the export of UN/LoCode for the locale specified. Please note that some of the country translations may still be missing.

## Contributors
* Denny Mueller - https://github.com/dennym

## Related
https://github.com/svenfuchs/rails-i18n
https://github.com/svenfuchs/i18n

## Version History
* 0.0.1 - Initial just generated locale and mixed translations

## License
MIT or GPL

## Special thanks
https://github.com/svenfuchs/rails-i18n
https://github.com/onomojo/i18n-country-translations