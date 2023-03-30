# frozen_string_literal: true

require_relative "lib/jekyll-external-link-accessibility/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-external-link-accessibility"
  spec.version = Jekyll::ExternalLinkAccessibility::VERSION
  spec.authors = ["Kudakwashe Siziva"]
  spec.email = ["kudakwashe@ombulabs.com"]

  spec.summary = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://example.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.2"

  spec.metadata["allowed_push_host"] = "Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://example.com"
  spec.metadata["changelog_uri"] = "https://example.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]
  spec.require_paths = ['lib']

  spec.add_dependency "jekyll", "~> 4.0.1"
  spec.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.5'
end
