module Test
  module WebHelpers
    module_function

    def web_app
      Snowpack::Web.application
    end
  end
end
