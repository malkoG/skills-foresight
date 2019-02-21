require_relative 'base'

require 'httparty'

module SkillsForesight
  module Services 
    class Github
      # TODO : Rate limit 문제를 해결해야함
      include HTTParty
      base_uri 'https://api.github.com'

      def service 
        'github'
      end

      def get_user(**options)
        response = self.class.get("/users/#{options[:username]}")
        raise InvalidUserError if response.headers['status'][0..2].to_i == 404

        JSON.parse response.to_s
      end
    end
  end
end