# frozen_string_literal: true

require "rails_helper"

RSpec.describe PublicRepos::ListPresenter do
  let(:presenter) { described_class.new }
  let(:json_response) {
    JSON.parse(File.read("#{Rails.root}/spec/support/ruby_repos_search_results.json")).to_h
  }

  describe "#call" do
    context "search results for 'ruby' search" do
      it "has all needed keys in an item" do
        presenter_result_keys = presenter.call(json_response["items"])
                                         .first
                                         .keys
        expect(presenter_result_keys).to eq([:name, :url, :description])
      end

      it "fetches data properly, thus no nils from test data" do
        presenter_item = presenter.call(json_response["items"]).first
        hash_with_nils = presenter_item.select { |_k, value| value.nil? }
        expect(hash_with_nils).to eq({})
      end
    end
  end
end