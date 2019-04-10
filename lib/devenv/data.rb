# frozen_string_literal: true

module Devenv
  module Data
    # Export /data folder under this path inside a VM:
    VM_DATA_PATH = '/dev/shm/devenv-data'

    # Path to the data folder on the host machine
    #
    # @return [String]
    #
    def self.source_path_host
      "#{Devenv.root_host}/data"
    end

    # Path to the source data folder on the VM machine
    #
    # @return [String]
    #
    def self.source_path_vm
      "#{Devenv.root_vm}/data"
    end

    # Path to the target data folder on the VM machine
    #
    # @return [String]
    #
    def self.target_path_vm
      VM_DATA_PATH
    end

    # Exports data to a minikube VM
    #
    def self.export
      remote_cmd = "install -d #{target_path_vm}"
      Devenv.sh "minikube ssh -- \"#{remote_cmd}\""
      remote_cmd = " cp -r #{source_path_vm}/* #{target_path_vm}"
      Devenv.sh "minikube ssh -- \"#{remote_cmd}\""
    end

    # Clears exported data foloder in a minikube VM
    #
    def self.clear
      remote_cmd = "rm -rf #{target_path_vm}/*"
      Devenv.sh "minikube ssh -- \"#{remote_cmd}\""
    end
  end # module Data
end # module Devenv
