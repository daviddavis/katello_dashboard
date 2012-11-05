require 'chronic_duration'
require 'chronic'

CURRENT_ITERATION = 8
DEADLINE = "November 15th, 2012 12:00 AM"

SCHEDULER.every '1s' do
  time_left = (Chronic.parse("#{DEADLINE}") - Time.now).to_i
  text = "#{ChronicDuration.output(time_left)} left"
  title = "Iteration ##{CURRENT_ITERATION}"
  send_event('iteration', { title: title, text: text })
end
