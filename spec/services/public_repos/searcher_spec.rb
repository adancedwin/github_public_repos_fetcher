# frozen_string_literal: true

require "rails_helper"

RSpec.describe PublicRepos::Searcher do
  let(:searcher) { described_class.new }

  describe "#call" do
    it "returns true when searching 'ruby'" do
      search_body = JSON.parse(File.read("#{Rails.root}/spec/support/ruby_repos_search_results.json"))
      stub_request(:get, "https://api.github.com/rate_limit").
        with(
          headers: {
            'Accept'=>'application/vnd.github.v3+json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: { key: "value" }.to_json, headers: {})
      stub_request(:get, "https://api.github.com/search/repositories?q=ruby").
        with(
          headers: {
            'Accept'=>'application/vnd.github.v3+json',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: search_body.to_json, headers: {})

      response = searcher.call(search_term: "ruby")
      expect(response[:success]).to eq(true)
    end
  end
end