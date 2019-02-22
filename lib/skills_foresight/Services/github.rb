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

        self.class.headers 'Authorization' => oauth_token
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
        response = self.class.get("/users/#{options[:username]}/repos")
        sleep_with_waiting

        JSON.parse response.to_s
      end

      protected
        def rate_limit
          5_000
        end
    end
  end
end