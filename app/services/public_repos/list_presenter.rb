class PublicRepos::ListPresenter
  def call(repos_json)
    build_repos(repos_json)
  end

  private

  def build_repos(repos_json)
    repos_json.map do |repo|
      {
        name: repo["full_name"],
        url: repo["html_url"],
        description: repo["description"]
      }
    end
  end
end