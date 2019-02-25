require 'skills_foresight/query_executer'
require 'skills_foresight/user'
require 'skills_foresight/logger'

module SkillsForesight
  class Analyzer
    attr_reader :user, :query_engine, :repositories, :statistics

    def initialize(username, **options)
      @query_engine = QueryExecuter.new(options[:service], token: options[:oauth_token], user_agent: options[:user_agent])
      @user = User.new(username, **options)
    end

    def analyze 
      @repositories = @user.repositories

      @statistics = {}
      @repositories.each do |repo|
        @statistics[repo] = @query_engine.analyze_contribution @user.name, repo
      end

      return @statistics
    end

    def print_report
      puts "Started Analyzing..."
      puts "===================="
      @statistics.keys.each do |project| 
        puts "[#{project}]"
        @statistics[project].each do |language, contribution| 
          puts "#{language} -- Additions : #{contribution['additions']} / Deletions : #{contribution['deletions']}"
        end
        puts "--------"
      end
      puts "===================="
    end

    def to_s
      "Analyzing User... @#{user.name} [from #{query_engine}]"
    end
  end
end
