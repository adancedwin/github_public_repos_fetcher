class PublicReposController < ApplicationController
  def show; end

  def index
    repos = PublicRepos::Searcher.new.call(search_term: params[:search] || "")

    render locals: { repos: repos }
  end
end