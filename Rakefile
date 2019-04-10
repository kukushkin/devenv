require_relative 'lib/devenv'


task :check_dependencies do
  Devenv.check_dependencies!
end

namespace :vm do
  desc 'Cleanup docker images/containers/volumes in minikube VM'
  task :cleanup => :check_dependencies do
    Devenv.sh 'minikube ssh -- docker system prune -af'
  end
end

desc 'Builds the devenv image dependencies'
task :build => :check_dependencies do
  Devenv::Images.images_all.each do |name|
    puts
    puts "** Building image '#{name}'"
    Devenv::Images.build(name)
  end
end


namespace :data do
  desc "Exports /data into a minikube VM folder: #{Devenv::Data.target_path_vm}"
  task :export => :check_dependencies do
    puts "** Exporting data"
    puts "from: #{Devenv::Data.source_path_host} (host)"
    puts "      #{Devenv::Data.source_path_vm} (mounted in minikube VM)"
    puts "  to: #{Devenv::Data.target_path_vm} (minikube VM)"
    Devenv::Data.export
  end

  desc "Clears exported data folder in VM: #{Devenv::Data.target_path_vm}"
  task :clear => :check_dependencies do
    puts "** Clearing exported data"
    puts "in: #{Devenv::Data.target_path_vm} (VM)"
    Devenv::Data.clear
  end
end

desc 'Brings the system up'
task :up => [:check_dependencies, :"data:export"] do
  Devenv::Resource.up
end

desc 'Brings the system down'
task :down => [:check_dependencies, :"data:clear"] do
  Devenv::Resource.down
end

namespace :jobs do
  desc 'Re-runs jobs'
  task :up => :check_dependencies do
    Devenv::Resource.down_jobs!
    Devenv::Resource.up_jobs!
  end

  desc 'Cleans up jobs'
  task :down => :check_dependencies do
    Devenv::Resource.down_jobs!
  end
end

namespace :sh do
  Devenv::Pod.all.each do |pod|
    desc "Starts a shell session in '#{pod.fullname}'"
    task pod.fullname.to_sym => :check_dependencies do
      pod.start_shell
    end
  end
end
