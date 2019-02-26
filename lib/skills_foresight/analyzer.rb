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
      @repositories = []
      @statistics = {}

      max_page = 1000
      (1..max_page).each do |page| 
        repositories = @user.repositories :page => page

        break if repositories.empty?

        repositories.each do |repo|
          @statistics[repo] = @query_engine.analyze_contribution @user.name, repo
        end

        @repositories = [*@repositories, *repositories]
      end

      return @statistics
    end

    def print_report
      puts "Started Analyzing..."
      puts "===================="
      @statistics.keys.each do |project| 
        puts "[#{project}]"

        puts ">> contributes for files <<" 
        @statistics[project]['files'].each do |filename, contribution|
          puts "#{filename} -- Additions : #{contribution['additions']} / Deletions : #{contribution['deletions']}"
        end

        puts ">> contributes for language <<"
        @statistics[project]['stats'].each do |language, contribution| 
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
