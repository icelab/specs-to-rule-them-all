require "time_math"

module Test
  module TimeHelpers
    class Helper
      attr_reader :now

      def initialize(now)
        @now = TimeMath(now)
      end

      def yesterday
        now.decrease(:day, 1).()
      end

      def tomorrow
        now.advance(:day, 1).()
      end

      def one_week_ago
        now.decrease(:week, 1).()
      end

      def one_week_from_now
        now.advance(:week, 1).()
      end

      def two_weeks_ago
        now.decrease(:week, 2).()
      end

      def one_month_ago
        now.decrease(:month, 1).()
      end

      def two_months_ago
        now.decrease(:month, 2).()
      end

      def one_hour_ago
        now.decrease(:hour, 1).()
      end

      def one_hour_from_now
        now.advance(:hour, 1).()
      end

      def one_year_from_now
        now.advance(:year, 1).()
      end
    end

    def time(now = Time.now)
      TimeHelper.new(now)
    end
  end
end
