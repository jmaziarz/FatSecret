require 'active_attr'
require 'active_support'
require 'fat_secret/relations/belongs_to'
require 'fat_secret/relations/has_many'
require 'fat_secret/relations/has_many_proxy'
require 'fat_Secret/relations'
require 'fat_secret/base'
require 'fat_secret/config'
require 'fat_secret/connection'
require 'fat_secret/food'
require 'fat_secret/results_proxy'
require 'fat_secret/serving'
require 'fat_secret/version'
require 'logger'
require 'open-uri'
require 'typhoeus'
require 'yajl'

module FatSecret

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= FatSecret::Config.new
    yield(configuration)
    return self.configuration
  end
end
