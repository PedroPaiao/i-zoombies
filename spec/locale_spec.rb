require 'rails_helper'

RSpec.describe do
  context 'Test locales' do
    it 'Is default locale' do
      expect(I18n.t('hello')).to eq('Hello world!')
    end
    it 'Is pt-BR locale' do
      I18n.locale = :'pt-BR'
      expect(I18n.t('hello')).to eq('Ola mundo!')
    end
    it 'Is es locale' do
      I18n.locale = :es
      expect(I18n.t('hello')).to eq('¡Hola mundo!')
    end
  end
end