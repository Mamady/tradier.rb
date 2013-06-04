require 'spec_helper'

describe Tradier::API::Markets do

  before do
    @client = Tradier::Client.new
  end

  describe "#quotes" do
    context "when a single symbol passed" do
      before do
        stub_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL"}).to_return(:body => fixture("quote.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "requests the correct resource" do
        @client.quotes("AAPL")
        expect(a_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL"})).to have_been_made
      end
      it "returns an array of quotes" do
        quotes = @client.quotes("AAPL")
        expect(quotes).to be_an Array
        expect(quotes.size).to eq(1)
        expect(quotes.first).to be_a Tradier::Quote
        expect(quotes.first.symbol).to eq 'AAPL'
      end
    end
    context "when multiple symbols passed as a comma delimited string" do
      before do
        stub_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL,GE"}).to_return(:body => fixture("quotes.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "requests the correct resource" do
        @client.quotes("AAPL,GE")
        expect(a_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL,GE"})).to have_been_made
      end
      it "returns an array of quotes" do
        quotes = @client.quotes("AAPL,GE")
        expect(quotes).to be_an Array
        expect(quotes.size).to eq(2)
        expect(quotes.first).to be_a Tradier::Quote
        expect(quotes.first.symbol).to eq 'AAPL'
      end
    end

    context "when multiple symbols passed as an array" do
      before do
        stub_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL,GE"}).to_return(:body => fixture("quotes.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "requests the correct resource" do
        @client.quotes(["AAPL","GE"])
        expect(a_get("/v1/markets/quotes").with(:query => {:symbols => "AAPL,GE"})).to have_been_made
      end
      it "returns an array of quotes" do
        quotes = @client.quotes(["AAPL","GE"])
        expect(quotes).to be_an Array
        expect(quotes.size).to eq(2)
        expect(quotes.first).to be_a Tradier::Quote
        expect(quotes.first.symbol).to eq 'AAPL'
      end
    end
  end

end