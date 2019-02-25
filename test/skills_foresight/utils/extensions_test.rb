require 'minitest/autorun'
require 'skills_foresight/utils/extension'

class SkillsForesight::Utils::ExtensionTest < MiniTest::Test

  def test_classify_extension_function
    assert_equal 'react', SkillsForesight::Utils::Extension::classify_extension('aass.jsx')
    assert_equal 'react', SkillsForesight::Utils::Extension::classify_extension('assd/assd.tsx')
    assert_equal 'typescript', SkillsForesight::Utils::Extension::classify_extension('index.ts')
    assert_equal 'ruby', SkillsForesight::Utils::Extension::classify_extension('application_controller.rb')
  end

end
