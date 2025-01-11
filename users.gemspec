require_relative "lib/users/version"

Gem::Specification.new do |spec|
  spec.name        = "users"
  spec.version     = Users::VERSION
  spec.authors     = [ "develumpen" ]
  spec.email       = [ "develumpen@breakabletoys.com" ]
  spec.homepage    = "https://github.com/develumpencom/users"
  spec.summary = "Simple user authentication engine"
  spec.description = "Simple user authentication engine"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/develumpencom/users"
  spec.metadata["changelog_uri"] = "https://github.com/develumpencom/users"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.1"
end
