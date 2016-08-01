require 'rails_helper'


describe Book do

  before(:each) do
    DatabaseCleaner.clean
  end

  describe 'Validates' do

    context 'Author' do
      it "returns Author can't be empty when author is empty" do
        book = build(:book, name: 'jp', isbn: 'ga', price: 13, img_url: 'An url', description: 'A description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:author]).to eq(['Author can not be empty'])
      end
    end

    context 'Name' do

      it "returns Name can't be empty when name is empty" do
        book = build(:book, isbn: 'ga', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:name]).to eq(['Name can not be empty'])
      end

      it 'returns Name&&author of two books can not be all the same' do
        create(:book, name: 'rhh', isbn: 'ga', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
        book=build(:book, name: 'rhh', isbn: 'newga', author: 'An author', price: 23, img_url: 'new url', description: 'new description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:name]).to eq(['Name&&author of two books can not be all the same'])
      end
    end

    context 'Isbn' do

      it "returns Isbn can't be empty when isbn is empty" do
        book = build(:book, name: 'rhh', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:isbn]).to eq(['Isbn can not be empty'])
      end

      it 'returns Isbn should be unique when isbn is repeated' do
        create(:book, name: 'jp', isbn: 'ga', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
        book=build(:book, name: 'rhh', isbn: 'ga', author: 'New author', price: 23, img_url: 'new url', description: 'new description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:isbn]).to eq(['Isbn should be unique'])
      end

    end

    context 'Price' do

      it 'returns Price should be a number' do
        book=build(:book, name: 'rhh', isbn: 'ga', author: 'New author', price: 'a23', img_url: 'new url', description: 'new description')
        book.valid?
        expect(book.errors.size).to eq 1
        expect(book.errors[:price]).to eq(['Price should be a number'])
      end

    end

  end

  describe 'Record' do

    it 'can be recorded when params are legal' do
      book=create(:book, name: 'rhh', isbn: 'ga', author: 'An author', price: 13, img_url: 'An url', description: 'A description')
      expect(Book.find('ga')).to eq book
    end

  end

  DatabaseCleaner.clean
end
