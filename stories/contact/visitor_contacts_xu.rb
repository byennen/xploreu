require File.dirname(__FILE__) + '/../helper'
require File.dirname(__FILE__) + '/steps/visitor_contacts_xu_steps.rb'

with_steps_for :visitor_contacts_xu do
  run File.dirname(__FILE__) + '/stories/visitor_contacts_xu.story', :type => RailsStory
end