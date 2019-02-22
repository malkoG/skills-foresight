module SkillsForesight 
  class ServiceNotFoundError < RuntimeError 
  end

  class InvalidUserError < RuntimeError 
  end

  class AuthorizationError < RuntimeError
  end

  class InvalidUserAgentError < RuntimeError
  end
end
require 'skills_foresight/analyzer'
