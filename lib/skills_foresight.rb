module SkillsForesight 
  class ServiceNotFoundError < RuntimeError 
  end

  class InvalidUserError < RuntimeError 
  end
end
require 'skills_foresight/analyzer'
