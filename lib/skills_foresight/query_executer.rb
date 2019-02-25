require 'skills_foresight/services/github'

module SkillsForesight
  class QueryExecuter 
    attr_reader :engine
    def initialize(service, **options)
      @@engine = select_engine(service, **options)
      raise ServiceNotFoundError if @@engine.nil?
    end

    def self.repositories(**options)
      @@engine.repositories(**options)
    end

    def self.get_user(**options)
      @@engine.get_user(**options)
    end

    def self.commits(**options)
      @@engine.commits(**options)
    end

    def self.contribution(**options)
      @@engine.contribution(**options)
    end

    def analyze_contribution(username, repository)
      commits = self.class.commits(username: username, repository: repository)
      
      contributions_report = {}
      commits.each do |commit|
        contribution = self.class.contribution **commit

        next if contribution.keys.empty?

        contribution.keys.each do |k|
#          puts contribution.inspect unless 

          if contributions_report[k].nil?
            contributions_report[k] = Hash.new(0)
            contributions_report[k]['additions'] = 0
            contributions_report[k]['deletions'] = 0
          end

          contributions_report[k]['additions'] += contribution[k]['additions']
          contributions_report[k]['deletions'] += contribution[k]['deletions']
        end
      end

      return contributions_report
    end

    def to_s
      @@engine.service
    end

    private 
      def select_engine(service, **options)
        case service
        when 'github' then SkillsForesight::Services::Github.new options[:token], options[:user_agent]
        else nil
        end
      end
  end
end