require 'rails_helper'

describe LinksController, type: :request do
  describe 'GET /links/{id}' do
    context 'success' do
      let(:link) { create(:link, original: 'www.github.com') }

      subject { get "/links/#{link.shorten}" }

      it 'returns 302 status' do
        subject
        expect(response.status).to eq 302
      end

      it 'redirects to an original url' do
        expect(subject).to redirect_to 'www.github.com'
      end
    end

    context 'failure' do
      subject { get '/links/xxyyzz' }

      it 'returns 404 status' do
        subject
        expect(response.status).to eq 404
      end

      it 'returns a not_found page' do
        expect(subject).to render_template(file: "#{Rails.root}/public/404.html")
      end
    end
  end

  describe 'POST /links' do
    context 'success' do
      subject do
        post '/links', params: { link: { original: 'www.github.com' } }
      end

      it 'returns 200 status' do
        subject
        expect(response.status).to eq 204
      end

      it 'creates a new link record' do
        expect{ subject }.to change { Link.count }.by 1
      end

      # it 'renders success page' do
      #   expect(subject).to redirect_to 'www.github.com'
      # end
    end

    context 'failure' do
      subject do
        post '/links', params: { link: { original: 'invalid-url,com' } }
      end

      it 'returns 422 status' do
        subject
        pp response.body
        expect(response.status).to eq 422
      end

      # it 're-renders a form' do
      #   expect(subject).to render_template(file: "#{Rails.root}/public/404.html")
      # end
    end
  end
end
