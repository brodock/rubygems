require 'rubygems/dependency'

module Bubble
  class Dependency < Gem::Dependency
    def initialize(name, version, options = {}, &blk)
      options.each do |k, v|
        options[k.to_s] = v
      end

      super(name, version)
    end
  end
end