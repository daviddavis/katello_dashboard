require 'ifukube'
require 'ruby-debug'

NEXT_RELEASE = "cloudforms-2.0.0"
PRODUCT = "CloudForms System Engine"
OPEN = ["NEW", "ASSIGNED"]

SCHEDULER.every '30s' do
  items  = []
  bz     = Ifukube.new

  # untriaged
  search = bz.search_bugs(:product => PRODUCT, :status => "NEW")
  new_bugs = search["bugs"]
  untriaged = new_bugs.select {|b| !b["keywords"].include?("Triaged") }
  items << { label: "Untriaged", value: untriaged.count }

  ## next release
  #search = bz.search_bugs(:product => PRODUCT, :flags => NEXT_RELEASE)
  #release_bugs = search["bugs"]
  #items << { label: "Next Release Bugs", value: release_bugs.count }

  ## open bugs
  #open = release_bugs.select {|b| OPEN_STAT.include?(b["status"]) }.count
  #items << { label: "Next Release and Open", value: "#{open} (#{open/release_bugs * 100.0}%)" }

  search = bz.search_bugs(:product => "Katello", :status => OPEN)
  items << { label: "Open Katello Bugs", value: search["bugs"].count }

  send_event("bugzilla", { items: items })
end
