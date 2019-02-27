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
      commits = [] 

      max_page = 1_000
      (1..max_page).each do |page|
        fetched_commits = self.class.commits(username: username, repository: repository, page: page)
        break if fetched_commits.empty?

        commits = [*commits, *fetched_commits]
      end

      contributions_report = {}
      contributions_report['stats'] = {}
      contributions_report['files'] = {}

      commits.each do |commit|
        contribution = self.class.contribution **commit
        next if contribution.keys.empty?

        contribution.keys.each do |filename|
          additions = contribution[filename]['additions']
          deletions = contribution[filename]['deletions']

          extension = Utils::Extension::classify_extension(filename)

          contributions_report['files'][filename] = Hash.new(0) if contributions_report['files'][filename].nil?
          
          contributions_report['files'][filename]['additions'] += additions
          contributions_report['files'][filename]['deletions'] += deletions

          contributions_report['stats'][extension] = Hash.new(0) if contributions_report['stats'][extension].nil?

          contributions_report['stats'][extension]['additions'] += additions
          contributions_report['stats'][extension]['deletions'] += deletions
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