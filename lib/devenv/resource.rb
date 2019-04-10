# frozen_string_literal: true

module Devenv
  module Resource
    #
    # Brings all resources up, applying all discovered configs/manifests
    #
    def self.up
      Devenv::Manifest.filenames.each do |filename|
        Devenv.sh "kubectl apply -f #{filename}"
      end
    end

    # Tears down all discovered resources
    #
    def self.down
      down_jobs!
      down_deployments!
      down_statefulsets!
      down_services!
      down_pvcs!
    end

    # Returns discovered deployment manifests
    #
    def self.deployments
      Devenv::Manifest.all.select { |m| m.kind == 'Deployment' }
    end

    # Returns discovered service manifests
    #
    def self.services
      Devenv::Manifest.all.select { |m| m.kind == 'Service' }
    end

    # Returns discovered stateful set manifests
    #
    def self.statefulsets
      Devenv::Manifest.all.select { |m| m.kind == 'StatefulSet' }
    end

    # Returns discovered persistent volume claim manifests
    #
    def self.pvcs
      Devenv::Manifest.all.select { |m| m.kind == 'PersistentVolumeClaim' }
    end

    # Returns discovered job manifests
    #
    def self.jobs
      Devenv::Manifest.all.select { |m| m.kind == 'Job' }
    end

    private # -ish

    def self.down_deployments!
      deployments.each do |m|
        begin
          Devenv.sh "kubectl delete deployment #{m.name}"
        rescue => e
          puts "ERROR: #{e}"
        end
      end
    end

    def self.down_services!
      services.each do |m|
        begin
          Devenv.sh "kubectl delete service #{m.name}"
        rescue => e
          puts "ERROR: #{e}"
        end
      end
    end

    def self.down_statefulsets!
      statefulsets.each do |m|
        begin
          Devenv.sh "kubectl delete statefulset #{m.name}"
        rescue => e
          puts "ERROR: #{e}"
        end
      end
    end

    def self.down_pvcs!
      pvcs.each do |m|
        begin
          Devenv.sh "kubectl delete pvc #{m.name}"
        rescue => e
          puts "ERROR: #{e}"
        end
      end
    end

    # Applies manifests with declared job resources
    #
    def self.up_jobs!
      jobs.each do |m|
        Devenv.sh "kubectl apply -f #{m.filename}"
      end
    end

    # Deletes declared jobs
    #
    def self.down_jobs!
      jobs.each do |m|
        begin
          Devenv.sh "kubectl delete job #{m.name}"
        rescue => e
          puts "ERROR: #{e}"
        end
      end
    end
  end # module Resource
end # module Devenv
