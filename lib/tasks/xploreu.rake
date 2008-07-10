if Rake::Task.task_defined?(:stories)
  Rake.application.tasks.delete(:stories)
end

task :stories do
  sh 'ruby stories/all.rb -c'
end