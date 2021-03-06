module SkillsForesight
  module Utils
    module Extension
      C_EXT          = %w[c Makefile CMakefile].freeze
      CPP_EXT        = %w[cpp].freeze
      CSHARP_EXT     = %w[cs].freeze

      JAVA_EXT       = %w[java].freeze
      KOTLIN_EXT     = %w[kt].freeze
      CLOJURE_EXT    = %w[clj cljs cljc].freeze

      RUBY_EXT       = %w[rb erb ru Rakefile Gemfile gemspec].freeze
      PYTHON_EXT     = %w[py Pipfile].freeze
      JAVASCRIPT_EXT = %w[js babelrc].freeze
      TYPESCRIPT_EXT = %w[ts tsconfig].freeze

      HTML_EXT       = %w[html].freeze
      CSS_EXT        = %w[css sass scss styl].freeze
      REACT_EXT      = %w[jsx tsx].freeze
      VUE_EXT        = %w[vue].freeze
      ELM_EXT        = %w[elm].freeze

      MARKDOWN_EXT   = %w[md markdown].freeze

      HASKELL_EXT    = %w[hs].freeze
      ERLANG_EXT     = %w[erl].freeze
      ELIXIR_EXT     = %w[ex exs].freeze
      ML_EXT         = %w[ml].freeze

      GO_EXT         = %w[go].freeze
      RUST_EXT       = %w[rs].freeze
      SHELL_EXT      = %w[sh zsh fish bashrc zshrc bash_profile].freeze

      IGNORE_EXT     = %w[lock gitignore json gz].freeze

      def self.classify_extension(filename, **options)
        extension = filename.split('.').last

        return 'ignore' if IGNORE_EXT.include? extension

        case extension
        when *C_EXT             then 'c'
        when *CPP_EXT           then 'cpp'
        when *CSHARP_EXT        then 'csharp'
        when *JAVA_EXT          then 'java'
        when *KOTLIN_EXT        then 'kotlin'
        when *CLOJURE_EXT       then 'clojure'
        when *RUBY_EXT          then 'ruby'
        when *PYTHON_EXT        then 'python'
        when *MARKDOWN_EXT      then 'markdown'
        when *JAVASCRIPT_EXT    then 'javascript'
        when *TYPESCRIPT_EXT    then 'typescript'
        when *REACT_EXT         then 'react'
        when *VUE_EXT           then 'vue'
        when *HTML_EXT          then 'html'
        when *CSS_EXT           then 'css'
        when *HASKELL_EXT       then 'haskell'
        when *ERLANG_EXT        then 'erlang'
        when *ELIXIR_EXT        then 'elixir'
        when *GO_EXT            then 'go'
        when *RUST_EXT          then 'rust'
        when *SHELL_EXT         then 'shell'
        else 'text'
        end
      end
    end
  end
end