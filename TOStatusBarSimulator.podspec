Pod::Spec.new do |s|
  s.name     = 'TOStatusBarSimulator'
  s.version  = '0.2.0'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'Replaces the iOS system status bar with a configurable mockup for the purpose of marketing screenshots.'
  s.homepage = 'https://github.com/TimOliver/TOStatusBarSimulator'
  s.author   = 'Tim Oliver'
  s.source   = { :git => 'https://github.com/TimOliver/TOStatusBarSimulator.git', :tag => s.version }
  s.platform = :ios, '8.0'
  s.source_files = 'TOStatusBarSimulator/**/*.{h,m}'
  s.resource_bundle = { 'TOStatusBarSimulator' => 'TOStatusBarSimulator/**/*.xcassets' }
  s.requires_arc = true
end
