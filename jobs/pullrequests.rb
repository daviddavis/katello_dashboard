require 'github_api'

SCHEDULER.every '30s' do
  pulls = Github.pull_requests.list("Katello", "katello").map do |pr|
    {
      label: pr.title.truncate(60),
      url: pr.url,
      value: pr.user.login,
    }
  end
  total = pulls.count
  pulls = pulls[0, 10] if pulls.count > 10
  shown = pulls.length

  send_event('pullrequests', { items: pulls, title: "Pull Requests (#{shown} of #{total})" })
end
