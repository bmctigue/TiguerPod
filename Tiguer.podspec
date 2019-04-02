#
#  Be sure to run `pod spec lint Tiguer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Tiguer"
  s.version      = "0.0.12"
  s.summary      = "Common source files."
  s.description  = "Common source files. Sourced from John Sundell mostly."
  s.license      = 'MIT'
  s.author       = { "Bruce McTigue" => "bmctigue@tiguer.com" }
  s.platform     = :ios, "12.2"
  s.source       = { :git => "https://github.com/bmctigue/Tiguer.git", :tag => "#{s.version}" }
  s.source_files  = "Tiguer"
  s.exclude_files = "Classes/Exclude"
  s.swift_version = "5.0"
  s.homepage     = "http://tiguer.com"
  s.static_framework = true
  s.dependency "Promis"
  s.dependency "NKCache"
end