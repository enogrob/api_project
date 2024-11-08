require 'rails_helper'

RSpec.describe "Books API", type: :request do
  let!(:books) { create_list(:book, 10) }
  let(:book_id) { books.first.id }

  describe "GET /api/v1/books" do
    before { get '/api/v1/books' }

    it "returns books" do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /api/v1/books" do
    let(:valid_attributes) { { book: { title: 'Harry Potter', author: 'J.K. Rowling', description: 'Fantasy novel' }} }

    context "when the request is valid" do
      before { post '/api/v1/books', params: valid_attributes }

      it "creates a book" do
        expect(JSON.parse(response.body)['title']).to eq('Harry Potter')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Additional tests for show, update, destroy...
end
