require 'skills_foresight/query_executer'

module SkillsForesight
  class User
    attr_reader :name, :information

    def initialize(name, **options)
      @name = name
      @information = QueryExecuter.get_user(username: name)
    end

    def repositories
      QueryExecuter.repositories(type: 'user', name: name)
    end
  end
end
