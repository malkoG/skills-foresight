module SkillsForesight
  module Utils
    module Extension
      C_EXT          = %w[c Makefile CMakefile].freeze
      RUBY_EXT       = %w[rb erb ru Rakefile].freeze
      PYTHON_EXT     = %w[py].freeze
      MARKDOWN_EXT   = %w[md markdown].freeze
      JAVASCRIPT_EXT = %w[js babelrc].freeze
      TYPESCRIPT_EXT = %w[ts tsconfig].freeze
      REACT_EXT      = %w[jsx tsx].freeze
      HTML_EXT       = %w[html].freeze
      CSS_EXT        = %w[css sass scss].freeze

      def self.classify_extension(filename)
        extension = filename.split('.').last

        case extension
        when *C_EXT             then 'c'
        when *RUBY_EXT          then 'ruby'
        when *PYTHON_EXT        then 'python'
        when *MARKDOWN_EXT      then 'markdown'
        when *JAVASCRIPT_EXT    then 'javascript'
        when *TYPESCRIPT_EXT    then 'typescript'
        when *REACT_EXT         then 'react'
        when *HTML_EXT          then 'html'
        when *CSS_EXT           then 'css'
        else 'text'
        end
      end
    end
  end
end