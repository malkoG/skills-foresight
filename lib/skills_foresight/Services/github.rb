require_relative 'base'

require 'httparty'

module SkillsForesight
  module Services 
    class Github < Base
      # TODO : Rate limit 문제를 해결해야함
      base_uri 'https://api.github.com'

      def initialize(oauth_token, user_agent)
        raise AuthorizationError if oauth_token.nil?
        raise InvalidUserAgentError if user_agent.nil?

        self.class.headers 'Authorization' => "token #{oauth_token}"
        self.class.headers 'User-Agent' => user_agent
      end

      def service 
        'github'
      end

      def get_user(**options)
        response = self.class.get("/users/#{options[:username]}")
        sleep_with_waiting
        raise InvalidUserError if response.headers['status'][0..2].to_i == 404

        JSON.parse response.to_s
      end

      def repositories(**options)
        response = self.class.get("/users/#{options[:username]}/repos?page=#{options[:page]}")
        sleep_with_waiting

        repositories = response.map do |repo|
            hashed_repo = Hash.new 
            hashed_repo[:repository_name] = repo['name']
            hashed_repo[:fork] = repo['fork']

            hashed_repo
        end

        repositories
      end

      def commits(**options)
        response = self.class.get("/repos/#{options[:username]}/#{options[:repository]}/commits?page=#{options[:page]}")
        sleep_with_waiting
        raise InvalidRepositoryError if response.headers['status'][0..2].to_i == 404

        result = []
        response.each do |commit|
          if commit['author'] && commit['author']['login'] == options[:username]
            dict = {}

            dict[:sha] = commit['sha']
            dict[:username] = options[:username]
            dict[:repository] = options[:repository]

            result << dict
          end
        end

        return result
      end

      def contribution(**options)
        response = self.class.get("/repos/#{options[:username]}/#{options[:repository]}/commits/#{options[:sha]}")
        sleep_with_waiting
        raise InvalidHashError if response.headers['status'][0..2].to_i == 404

        result = {}
        response['files'].each do |file| 
          filename = file['filename']
          result[filename] = Hash.new(0) if result[filename].nil?

          result[filename]['additions'] += file['additions']
          result[filename]['deletions'] += file['deletions']
        end

        return result
      end

      protected
        def rate_limit
          5_000
        end
    end
  end
end