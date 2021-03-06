
describe 'single call' do
  it 'translates correctly' do
    expect(I18n.t(:PLWAW, scope: :cities)).to eq 'Warszawa'
  end
end

Dir.glob('rails/locale/iso_639-1/*.yml') do |locale_file|
  # locale rof is missing in https://github.com/tigrish/iso/blob/master/data/iso-639-1.yml
  next if locale_file == 'rails/locale/iso_639-1/rof.yml'

  describe locale_file do
    it_behaves_like 'a valid locale file', locale_file
    it { is_expected.to be_a_subset_of 'rails/locale/iso_639-1/en.yml' }

    context 'file structure' do
      it 'ensures correctness' do
        locale = setup_locale(locale_file)

        translations = I18n.backend.send(:translations)
        keys = translations[locale.to_sym][:cities].keys

        keys.each do |city_code|
          puts city_code
          expect(I18n.t(city_code, scope: :cities, separator: '\001')).to_not eq city_code
          expect(I18n.t(city_code, scope: :cities, separator: '\001').include?('translation missing')).to be_falsy
        end
      end
    end
  end
end

def setup_locale(locale_file)
  locale_file.split('/').last.split('.').first
end
