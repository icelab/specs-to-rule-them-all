module Test
  module DatabaseHelpers
    module_function

    def relations
      rom.relations
    end

    def rom
      Snowpack.application["persistence.rom"]
    end

    def db
      Snowpack.application["persistence.db"]
    end
  end
end
