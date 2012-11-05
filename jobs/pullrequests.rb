require 'github_api'

SHOWN = 15

# do not set lower than 60
SCHEDULER.every '65s' do
  pulls = Github.pull_requests.list("Katello", "katello").map do |pr|
    {
      label: pr.title.truncate(50),
      url: pr.url,
      value: pr.user.login,
    }
  end
  total = pulls.count
  pulls = pulls[0, SHOWN] if pulls.count > SHOWN
  shown = pulls.length

  send_event('pullrequests', { items: pulls, title: "Pull Requests (#{shown} of #{total})" })
end
