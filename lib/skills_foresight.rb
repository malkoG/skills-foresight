module SkillsForesight 
  class ServiceNotFoundError < RuntimeError 
  end

  class InvalidUserError < RuntimeError 
  end

  class AuthorizationError < RuntimeError
  end

  class InvalidUserAgentError < RuntimeError
  end

  class InvalidRepositoryError < RuntimeError
  end

  class InvalidHashError < RuntimeError
  end
end

require 'skills_foresight/utils/extension'
require 'skills_foresight/analyzer'
