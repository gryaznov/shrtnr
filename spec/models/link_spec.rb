require 'rails_helper'

describe Link, type: :model do
  it { should have_readonly_attribute(:shorten) }
  it { should have_db_index(:shorten) }
  # For some reason the uniqueness shoulda matcher does not work as expected
  # always fails. It seems the reason is somewhere in the gem itself
  # (see: https://github.com/thoughtbot/shoulda-matchers/issues/935)
  # it { should validate_uniqueness_of(:shorten) }

  describe 'original url format validation' do
    let(:validation_error) { ActiveRecord::RecordInvalid }

    it 'raises an error if original url is invalid' do
      %w[www,google,com google,com www.googlecom].each do |invalid|
        expect { create(:link, original: invalid) }.to raise_error(validation_error)
      end
    end

    it 'does not raise an error if original url is valid' do
      %w[www.google.com www.g.com http://www.google.com https://google.com].each do |valid|
        expect { create(:link, original: valid) }.not_to raise_error
      end
    end
  end

  describe '.generate_shorten' do
    it 'shorten version length is 6 characters' do
      expect(Link.generate_shorten.length).to eq 6
    end
  end

  describe 'set_shorten callback' do
    let(:link) { create(:link, original: 'www.google.com', shorten: '') }

    it 'shorten is created' do
      expect(link.shorten).not_to be_empty
    end

    it 'shorten is not equal to the origin' do
      expect(link.shorten).not_to eq 'www.google.com'
    end
  end
end
