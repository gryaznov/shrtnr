require 'rails_helper'

describe Link, type: :model do
  it { should validate_presence_of(:original)  }
  it { should validate_uniqueness_of(:shorten) }
  it { should have_readonly_attribute(:shorten) }
  it { should have_db_index(:shorten) }

  describe 'original url format validation' do
    let(:validation_error) { ActiveRecord::RecordInvalid }

    it 'raises an error if original url is invalid' do
      %w[www,google,com www.com google,com www.googlecom http://www.google.com].each do |invalid|
        expect { create(:link, original: invalid) }.to raise_error(validation_error)
      end
    end

    it 'does not raise an error if original url is valid' do
      %w[www.google.com www.g.com google.com http://www.google.com google.com].each do |valid|
        expect { create(:link, original: valid) }.not_to raise_error
      end
    end
  end

  describe '#cut' do
    let(:link) { build(:link, original: 'www.google.com') }

    it 'shorten version includes shrtnr host' do
      expect(link.cut).to match %r{http:\/\/www.example.com\/+}
    end

    it 'shorten version length is between 5 and 7 characters' do
      link.save!
      expect(link.shorten.length).to be_within(5).of(7)
    end
  end
end
