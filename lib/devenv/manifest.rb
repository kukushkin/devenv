# frozen_string_literal: true
require 'yaml'
require 'pathname'

module Devenv
  #
  # Represents a single k8s resource manifest file
  #
  class Manifest
    MANIFEST_GLOB = Devenv.root_host.join('conf', '**', '*.yml')

    attr_reader :filename, :data

    # Constructs a new Manifest object
    #
    # @param filename [String] a .yml file the manifest is loaded from
    # @param data [Hash] a parsed document
    #
    def initialize(filename, data)
      @filename = filename
      @data = data.dup # FIXME: deep_dup?
    end

    # Helper methods to access manifest properties
    #
    def kind
      data['kind']
    end

    def metadata
      data['metadata']
    end

    def spec
      data['spec']
    end

    def name
      metadata['name']
    end

    # Returns a list of manifests loaded from .yml file
    #
    # @return [Array<Manifest>]
    #
    def self.load(filename)
      YAML.load_documents(File.read(filename)).map do |data|
        Manifest.new(filename, data)
      end
    end

    # Returns a list of found manifest files
    #
    # @return [Array<Pathname>]
    #
    def self.filenames
      Dir.glob(MANIFEST_GLOB)
    end

    # Returns a list of all found and loaded manifests
    #
    # @return [Array<Manifest>]
    #
    def self.all
      @manifest ||= filenames.map { |filename| load(filename) }.flatten
    end
  end # class Manifest
end # module Devenv
