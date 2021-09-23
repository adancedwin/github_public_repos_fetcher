# frozen_string_literal: true

# Searching Public Github repositories based on parameters provided
class PublicRepos::Searcher
  def call(search_term:)
    return failed_search unless input_valid?(search_term)

    search(search_term)
  end

  private

  def search(search_term)
    result = GithubApi::V3::RequestSender.new.repositories(search_term)
    repos_json = result["items"]
    return failed_search unless repos_json.present?

    repos_json = PublicRepos::ListPresenter.new.call(repos_json)
    { success: true, result: repos_json }
  end

  def input_valid?(input)
    PublicRepos::InputValidator.new.valid?(input)
  end

  def failed_search
    { success: false, result: "No result were found, please try different search term" }
  end
end
