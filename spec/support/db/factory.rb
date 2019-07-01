require "rom/factory"
require_relative "helpers"

module Test
  Factory = ROM::Factory.configure do |config|
    config.rom = Test::DatabaseHelpers.rom
  end

  Dir[Pathname(__FILE__).dirname.join("../../factories/**/*.rb")].each(&method(:require))

  class FactoryHelper < Module
    attr_reader :namespace

    def initialize(namespace = nil)
      @namespace = namespace

      factory = entity_namespace ? Factory.struct_namespace(entity_namespace) : Factory

      define_method(:factory) do
        factory
      end
    end

    private

    def entity_namespace
      return @entity_namespace if defined?(@entity_namespace)

      @entity_namespace =
        begin
          require "#{namespace}/entities"
          Test::Helpers.inflector[namespace, :camelize, :constantize].const_get(:Entities)
        rescue LoadError
        end
    end
  end
end
