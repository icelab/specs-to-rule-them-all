module Test
  module Helpers
    module_function

    def app
      Snowpack.application
    end

    def inflector
      Snowpack.application[:inflector]
    end
  end
end
