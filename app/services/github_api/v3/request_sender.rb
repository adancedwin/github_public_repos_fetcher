class GithubApi::V3::RequestSender
  include HTTParty

  base_uri "https://api.github.com"

  def initialize
    @options = { headers: { "Accept": "application/vnd.github.v3+json" } }
  end

  def repositories(repo_name)
    get("/search/repositories?q=#{repo_name}")
  end

  def rate_limit
    get("/rate_limit")
  end

  private

  def get(path)
    response = self.class.get(path, @options)
    raise ApiError, "Api fetch error. Code: #{response.code}" unless response.success?

    JSON(response.body)
  rescue JSON::JSONError
    raise ApiError, "Response parse error"
  end
end