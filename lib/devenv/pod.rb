# frozen_string_literal: true

module Devenv
  class Pod
    DEFAULT_SHELL = '/bin/bash'

    attr_reader :name, :fullname

    def initialize(fullname)
      @fullname = fullname
      @name = fullname.split('-').first
    end

    def start_shell(shell_cmd = DEFAULT_SHELL)
      Devenv.sh("kubectl exec -ti #{fullname} #{shell_cmd}")
    end

    # Returns a list of running pod names
    #
    def self.names
      @names ||= `kubectl get pods -o name`.split("\n")
      @names.map { |n| n.sub('pods/', '') }
    end

    # Returns a list of running pods
    #
    def self.all
      names.map { |n| new(n) }
    end
  end # class Pod
end # module Devenv
