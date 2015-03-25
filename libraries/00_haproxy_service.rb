#
# Cookbook Name:: haproxy-ng
# Resource:: service
#

class Chef::Resource
  class HaproxyService < Chef::Resource
    identity_attr :name

    def initialize(name, run_context = nil)
      super
      @name = name
      @resource_name = :haproxy_service
      @provider = Chef::Provider::HaproxyService
      @allowed_actions = [:create, :delete, :enable, :disable, :start, :stop]
      @action = [:create, :enable, :start]
    end

    def cookbook(arg = nil)
      set_or_return(
        :cookbook, arg,
        :kind_of => String,
        :default => 'haproxy-ng'
      )
    end

    def service_provider(arg = nil)
      set_or_return(
        :service_provider, arg,
        :kind_of => Chef::Provider::Service
        :default => Chef::Platform.find_provider_for_node node, :service
      )
    end
  end
end

#
# Cookbook Name:: haproxy-ng
# Provider:: Service
#

class Chef::Provider
  class HaproxyService < Chef::Provider
    def initialize(*args)
      super
    end

    def load_current_resource
      @current_resource ||=
        Chef::Resource::HaproxyService.new(new_resource.name)
      @current_resource
    end
  end
end
