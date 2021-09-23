class PublicRepos::InputValidator
  def valid?(input)
    valid_length?(input) && valid_operators?(input) && !rate_limit_exceed?
  end

  private

  attr_reader :params

  def valid_length?(value)
    value.length >= 1 && value.length < 257
  end

  def valid_operators?(value)
    value = value.downcase
    operator_count = 0
    operators = %w[and or not]
    operators.each do |operator|
      # We're searching for operators thus spaces around the value
      operator_count += value.gsub(/(?= #{operator} )/).count

      return false if operator_count > 5
    end

    true
  end

  def rate_limit_exceed?
    remaining_rate = ::GithubApi::V3::RequestSender.new
                                                   .rate_limit
                                                   .dig("resources", "search", "remaining") || 0
    remaining_rate < 0
  end
end