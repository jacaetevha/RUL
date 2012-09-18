# encoding: UTF-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "RUL"
  s.version     = "0.0.2"
  s.authors     = ["Jason Rogers"]
  s.email       = ["jacaetevha@gmail.com"]
  s.homepage    = "https://github.com/jacaetevha/RUL"
  s.summary     = %q{UUID-aware logging for Rails}
  s.description = %q{The Rails UUID-aware Logger (RUL) is a plugin that adds a UUID from the current thread to all messages getting logged. With a UUID-aware log statement, you can more easily track your user's activity through your application.}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
