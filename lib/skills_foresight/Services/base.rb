require 'httparty'

module SkillsForesight
  module Services
    class Base
      include HTTParty

      HOURS = 3_600

      protected
        def rate_limit
          HOURS
        end

        def sleep_with_waiting
          sleep(HOURS / rate_limit)
        end
    end
  end
end