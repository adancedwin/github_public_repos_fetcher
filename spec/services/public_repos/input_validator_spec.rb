# frozen_string_literal: true

require "rails_helper"

RSpec.describe PublicRepos::InputValidator do
  before(:each) do
    stub_request(:get, "https://api.github.com/rate_limit").
      with(
        headers: {
          'Accept'=>'application/vnd.github.v3+json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Ruby'
        }).
      to_return(status: 200, body: { key: "value" }.to_json, headers: {})
  end

  let(:input_validator) { described_class.new }

  describe "#valid?" do
    context "valid cases" do
      it "returns true when searching 'ruby'" do
        expect(input_validator.valid?("ruby")).to eq(true)
      end

      it "returns true when searching 'go'" do
        expect(input_validator.valid?("go")).to eq(true)
      end

      it "returns true when using one operator" do
        input = "ruby AND javascript"
        expect(input_validator.valid?(input)).to eq(true)
      end

      it "returns true when using max amount of operators" do
        input = "ruby AND nodejs OR python OR java OR scala OR go"
        expect(input_validator.valid?(input)).to eq(true)
      end
    end

    context "invalid cases" do
      it "returns false when search is empty" do
        expect(input_validator.valid?("")).to eq(false)
      end

      it "returns false when using 6 operators" do
        input = "ruby AND nodejs OR python OR java OR scala OR go OR kotlin"
        expect(input_validator.valid?(input)).to eq(false)
      end
    end
  end
end