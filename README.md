# Devenv

A development environment, intended to be run on a local machine in a *minikube* cluster.

**devenv** consists of a cluster configuration, and includes some docker images that can be used as a development environment for applications together with [kplay](https://github.com/kukushkin/kplay).

## Requirements

* [VirtualBox](https://www.virtualbox.org/)
(any other hypervisor supported by minikube will probably work as well, but is untested)
* [minikube](https://github.com/kubernetes/minikube)
* Ruby (2.x)

## Installation (Mac OS X)

First, set up *Virtualbox* and *minikube*. On Mac OS X the easiest way is to use `brew cask`:

```
> brew cask install virtualbox
> brew cask install minikube
```

Then clone the project into a local folder:
```
> git clone git@github.com:kukushkin/devenv.git
```

Finally, visit the project's folder and build the dependencies (docker images used by **devenv**):
```
> cd devenv
> rake build
```

## Usage

### What's inside -- Docker images

The project contains some docker images that can be used together with *kplay* to start a pod and mount a local project inside. This is an intended way to work with the applications/projects you develop locally.

The images can be found under `./images`, each one in a separate folder. Currently, these images are available as base images for *kplay*:

* dev -- vanilla Ubuntu (16.04) environment
* ruby-dev -- vanilla Ubuntu (16.04) environment, ruby 2.4 and some common gems
* ruby-dev-alpine -- experimental Alpine-based image, with ruby 2.4

These images together with other images defined in `./images` are built and made available in a VM local docker registry by running:
```
> rake build
```

To use some custom docker image that you don't want to push to the shared `devenv` repository, add them under `./images.local`. These will be built automatically by `rake build`, but won't be added to git repository as the whole folder is git-ignored.

### What's inside -- Cluster configuration

**devenv** contains a set of resource configuration files that describe the local deployment of a system. These files can be found under `./conf`, and they are processed when you are bringing the cluster up or down

### Commands

```bash
rake -T     # Lists available commands
rake build  # Builds the dependencies (docker images from ./images and ./images.local)
rake up     # Brings the cluster up
rake down   # Brings the cluster down
rake sh:<pod-name> # Opens a shell session in a running pod
```

Other than the abovementioned commands, you can use standard *minikube*/*kubectl* tools to interact with the cluster.


## Service Images


--
