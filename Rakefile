# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'run'
  app.codesign_certificate = ENV['CODESIGN_CERTIFICATE_NAME']
  app.provisioning_profile = ENV['PROVISIONING_PROFILE_PATH']
  app.frameworks += ['SpriteKit', 'GameController']
  app.interface_orientations = [:landscape_left, :landscape_right]
end
