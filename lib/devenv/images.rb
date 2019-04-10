# frozen_string_literal: true

module Devenv
  module Images
    # List devenv image names
    #
    def self.images
      Dir.glob(Devenv.root_host.join('images', '*'))
        .select { |fn| File.directory?(fn) }
        .map { |n| n.split('/').last }.sort
    end

    # List local devenv image names
    #
    def self.images_local
      Dir.glob(Devenv.root_host.join('images.local', '*'))
        .select { |fn| File.directory?(fn) }
        .map { |n| n.split('/').last }.sort
    end

    # Lists all images, global and local
    #
    def self.images_all
      (images + images_local).uniq.sort
    end

    # Builds an image inside a minikube VM
    #
    def self.build(name)
      dir_vm = images_local.include?(name) ? "#{Devenv.root_vm}/images.local" : "#{Devenv.root_vm}/images"
      remote_cmd = "cd #{dir_vm}; docker build -t #{name} #{name}"
      Devenv.sh "minikube ssh -- \"#{remote_cmd}\""
    end
  end # module Images
end # module Devenv
