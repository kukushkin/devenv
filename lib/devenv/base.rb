# frozen_string_literal: true

module Devenv
  # Returns the devenv project's root on host
  #
  def self.root_host
    Pathname.new(__dir__).join('..').join('..').expand_path
  end

  # Returns the devenv project's root in VM
  #
  def self.root_vm
    vm_mount_point(root_host)
  end

  # Returns the OS id
  #
  def self.host_os
    `uname`.split(' ').first.downcase.to_sym
  end

  # Returns mounted host folder, path on host
  #
  def self.hostfolder_host
    if host_os == :linux
      '/home/'
    else
      # FIXME: here only Mac OS X is supported
      '/Users/'
    end
  end

  # Returns mounted host folder, path on minikube VM
  #
  def self.hostfolder_vm
    if host_os == :linux
      '/hosthome/'
    else
      # FIXME: here only Mac OS X is supported
      '/Users/'
    end
  end

  # Mounts project folder inside minikube VM
  #
  # @param host_path [String] path on host
  #
  # @return [String] path in VM where the host_path is mounted
  #
  def self.vm_mount_point(host_path)
    unless host_path.to_s.start_with?(hostfolder_host.to_s)
      raise ArgumentError, "Failed to find mount point for: '#{host_path}', parent is not mounted"
    end
    Pathname.new(host_path.to_s.sub(hostfolder_host.to_s, hostfolder_vm.to_s))
  end

  # Executes a shell command
  #
  def self.sh(*args)
    cmd = args.join(' ')
    system cmd or raise "FAILED: #{cmd}"
  end

  #
  # Checks if dependencies are present
  #
  def self.check_dependencies!
    check_minikube!
    check_kubectl!
  end

  # Checks if minikube is present
  #
  def self.check_minikube!
    `which minikube`
  end

  # Checks if minikube is present
  #
  def self.check_kubectl!
    `which kubectl`
  end
end # module Devenv
