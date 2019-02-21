require 'skills_foresight/query_executer'
require 'skills_foresight/user'
require 'skills_foresight/logger'

module SkillsForesight
  class Analyzer
    attr_reader :user, :query_engine
    
    def initialize(username, **options)
      @query_engine = QueryExecuter.new(options[:service])
      @user = User.new(username, **options)
    end

    def to_s
      "Analyzing User... @#{user.name} [from #{query_engine}]"
    end 

    private 
      def load_service(service)
        case service
        when 'github' then Services::Github.new
        else nil
        end
      end
  end
end
