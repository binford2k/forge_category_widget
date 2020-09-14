#! /usr/bin/env ruby
require 'puppet_forge'
require 'json'

modules = PuppetForge::Module.where(endorsements: 'supported approved partner')
modules.unpaginated.each do |mod|
  cache                              = {}
  cache[:current_release]            = {}
  cache[:current_release][:metadata] = {}

  cache[:slug]                                 = mod.slug
  cache[:current_release][:version]            = mod.current_release.version
  cache[:current_release][:updated_at]         = mod.current_release.updated_at
  cache[:current_release][:metadata][:summary] = mod.current_release.metadata[:summary]
  cache[:current_release][:metadata][:author]  = mod.current_release.metadata[:author]

  File.write("data/#{mod.slug}.json", cache.to_json)
end
