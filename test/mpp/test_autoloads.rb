# frozen_string_literal: true

require "test_helper"

class TestAutoloads < Minitest::Test
  def test_public_autoloads_define_the_advertised_constants
    assert_autoloads_resolve(Mpp)
    assert_autoloads_resolve(Mpp::Server)
    assert_autoloads_resolve(Mpp::Methods::Tempo)
  end

  private

  def assert_autoloads_resolve(namespace)
    namespace.constants(false).each do |name|
      next unless namespace.autoload?(name)

      namespace.const_get(name, false)
      assert namespace.const_defined?(name, false), "#{namespace}::#{name} was not defined by its autoload"
    rescue NameError => error
      flunk "#{namespace}::#{name} has a dangling autoload: #{error.message}"
    end
  end
end
