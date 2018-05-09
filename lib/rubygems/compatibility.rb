# frozen_string_literal: true
# :stopdoc:

#--
# This file contains all sorts of little compatibility hacks that we've
# had to introduce over the years. Quarantining them into one file helps
# us know when we can get rid of them.
#
# Ruby 1.9.x has introduced some things that are awkward, and we need to
# support them, so we define some constants to use later.
#++

module Gem
  RubyGemsVersion = VERSION

  # TODO remove at RubyGems 3

  RbConfigPriorities = %w[
    MAJOR
    MINOR
    TEENY
    EXEEXT RUBY_SO_NAME arch bindir datadir libdir ruby_install_name
    ruby_version rubylibprefix sitedir sitelibdir vendordir vendorlibdir
    rubylibdir
  ]

  unless defined?(ConfigMap)
    ##
    # Configuration settings from ::RbConfig
    ConfigMap = Hash.new do |cm, key| # TODO remove at RubyGems 3
      cm[key] = RbConfig::CONFIG[key.to_s]
    end
  else
    RbConfigPriorities.each do |key|
      ConfigMap[key.to_sym] = RbConfig::CONFIG[key]
    end
  end

  RubyGemsPackageVersion = VERSION
end

# https://github.com/ruby/csv/pull/30
unless String.method_defined?(:match?)
  module Gem
    module MatchP
      refine String do
        def match?(pattern)
          pattern === self
        end
      end
    end

    refine Regexp do
      def match?(string)
        self === string
      end
    end
  end

end
