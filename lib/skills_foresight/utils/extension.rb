module SkillsForesight
  module Utils
    module Extension
      C_EXT          = %w[c Makefile CMakefile].freeze
      CPP_EXT        = %w[cpp].freeze
      CSHARP_EXT     = %w[cs].freeze

      JAVA_EXT       = %w[java].freeze
      KOTLIN_EXT     = %w[kt].freeze
      CLOJURE_EXT    = %w[clj cljs cljc].freeze

      RUBY_EXT       = %w[rb erb ru Rakefile Gemfile].freeze
      PYTHON_EXT     = %w[py].freeze
      MARKDOWN_EXT   = %w[md markdown].freeze
      JAVASCRIPT_EXT = %w[js babelrc].freeze
      TYPESCRIPT_EXT = %w[ts tsconfig].freeze
      REACT_EXT      = %w[jsx tsx].freeze
      HTML_EXT       = %w[html].freeze
      CSS_EXT        = %w[css sass scss].freeze
      HASKELL_EXT    = %w[hs].freeze
      ELIXIR_EXT     = %w[ex exs].freeze

      def self.classify_extension(filename, **options)
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
        when *HASKELL_EXT       then 'haskell'
        when *KOTLIN_EXT        then 'kotlin'
        when *CPP_EXT           then 'cpp'
        else 'text'
        end
      end
    end
  end
end