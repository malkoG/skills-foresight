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
      @statistics = []

      max_page = 20
      (1..max_page).each do |page| 
        repositories = @user.repositories :page => page

        break if repositories.empty?

        repositories.each do |repo|
          repository_information = {}
          repository_information['repository_name'] = repo[:repository_name]
          repository_information['fork'] = repo[:fork]
          repository_information['report'] = @query_engine.analyze_contribution @user.name, repo[:repository_name]

          @statistics << repository_information
        end

        @repositories = [*@repositories, *repositories]
      end

      return @statistics
    end

    def print_report
      puts "Started Analyzing..."
      puts "===================="
      @statistics.each do |project| 
        puts "[#{project['repository_name']}#{project['fork'] ? '(forked)' : ''}]"

        puts ">> contributes for files <<" 
        project['report']['files'].each do |filename, contribution|
          puts "#{filename} -- Additions : #{contribution['additions']} / Deletions : #{contribution['deletions']}"
        end

        puts ">> contributes for language <<"
        project['report']['stats'].each do |language, contribution| 
          puts "#{language} -- Additions : #{contribution['additions']} / Deletions : #{contribution['deletions']}"
        end

        puts ">> total byte counts of code for languages <<"
        project['report']['total'].each do |language, bytes|
          puts "#{language} -> #{bytes}"
        end

        puts "--------"
      end
    end

    def to_s
      "Analyzing User... @#{user.name} [from #{query_engine}]"
    end
  end
end
