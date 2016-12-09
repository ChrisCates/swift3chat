Pod::Spec.new do |s|
s.name             = 's3c'
s.version          = '0.1.0'
s.summary          = 'Finally a Chat UI for Swift 3'

s.description      = <<-DESC
Finally a Chat UI for Swift 3!
DESC

s.homepage         = 'https://github.com/ChrisCates/Swift3Chat'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Chris Cates' => 'hello@chriscates.ca' }
s.source           = { :git => 'https://github.com/ChrisCates/Swift3Chat.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.source_files = '*.{swift,plist}'

end
