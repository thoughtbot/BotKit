Pod::Spec.new do |s|
  s.name         = "BotKit"
  s.version      = "0.0.1"
  s.summary      = "BotKit is a Cocoa Touch static library for use in iOS projects."
  s.homepage     = "https://github.com/thoughtbot/botkit"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors       = { "Mark Adams" => "mark@thoughtbot.com", "Gordon Fontenot" => "gordon@thoughtbot.com", "Diana Zmuda" => "diana@apprentice.io" }
  s.source       = { 
    :git => "https://github.com/thoughtbot/botkit.git", 
    :tag => "0.0.1"
  }

  s.platform     = :ios, '5.0'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end