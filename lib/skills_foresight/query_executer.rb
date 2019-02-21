require 'skills_foresight/services/github'

module SkillsForesight
  class QueryExecuter 
    attr_reader :engine
    def initialize(service)
      @@engine = select_engine(service)
      raise ServiceNotFoundError if @@engine.nil?
    end

    def self.repositories(**options)
      @@engine.repositories(**options)
    end

    def self.get_user(**options)
      @@engine.get_user(**options)
    end

    def to_s
      @@engine.service
    end

    private 
      def select_engine(service)
        case service
        when 'github' then SkillsForesight::Services::Github.new
        else nil
        end
      end
  end
end