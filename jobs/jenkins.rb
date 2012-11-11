require 'jenkins-remote-api'

JENKINS_JOBS = [
    'katello-build',
    'katello-unit',
    'katello-cli-unittests',
    'converge-ui-build',
    'katello-candlepin',
    'katello-pulp',
    'katello-gui',
    'katello-api'
  ]

SCHEDULER.every "20s" do
  jenkins = Ci::Jenkins.new('http://hudson.rhq.lab.eng.bos.redhat.com:8080/hudson')
  items = []

  JENKINS_JOBS.each do |job|
    items << {
      label: job,
      value: jenkins.current_status_on_job(job)
    }
  end

  send_event('jenkins', { items: items })
end
