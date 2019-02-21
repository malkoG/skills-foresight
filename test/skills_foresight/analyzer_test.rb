require 'minitest/autorun'
require 'skills_foresight'

class SkillsForesight::AnalyzerTest < MiniTest::Test
  def setup
    @valid_username = "malkoG"
    @valid_service  = "github"
    @invalid_username = "kkkoooodddiinnngggwwaarrriiiioeeoror"
    @analyzer_instance  = SkillsForesight::Analyzer.new(@valid_username, :service => @valid_service)
  end
  
  def test_string_conversion
    assert_equal "Analyzing User... @#{@valid_username} [from #{@valid_service}]", @analyzer_instance.to_s
  end

  def test_service_not_found_exception 
    assert_raises SkillsForesight::ServiceNotFoundError do
      SkillsForesight::Analyzer.new(@invalid_username)
    end
  end

  def test_invalid_user_exception 
    assert_raises SkillsForesight::InvalidUserError do
      SkillsForesight::Analyzer.new(@invalid_username, :service => @valid_service)      
    end
  end
end
