$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "some_html/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "some_html"
  s.version     = SomeHtml::VERSION
  s.authors     = ["toxix"]
  s.email       = ["no-spam"]
  s.homepage    = "https://github.com/toxix/some_html"
  s.summary     = "allows xss safe html markups"
  s.description = "some_html allows some safe html markups, while prevent xss and site markup (not closed html-Tags, will be escaped). Ideal for display content edited in  WYSIWYG editors like ckeditor"

  s.rubyforge_project = "didactic_clock"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
end
