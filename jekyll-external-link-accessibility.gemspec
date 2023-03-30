# frozen_string_literal: true

require_relative "lib/jekyll-external-link-accessibility/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-external-link-accessibility"
  spec.version = Jekyll::ExternalLinkAccessibility::VERSION
  spec.authors = ["Kudakwashe Siziva"]
  spec.email = ["kudakwashe@ombulabs.com"]

  spec.summary = "A simple gem to add accessibility to external links in blog posts"
  spec.description = "Knows how to target external `a` tags and accessibility attributes"
  spec.homepage = " https://github.com/fastruby/jekyll-external-link-accessibility"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.2"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = " https://github.com/fastruby/jekyll-external-link-accessibility"
  spec.metadata["changelog_uri"] = " https://github.com/fastruby/jekyll-external-link-accessibility"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "README.md"]
  spec.require_paths = ['lib']

  spec.add_dependency "jekyll", "~> 4.0.1"
  spec.add_runtime_dependency 'nokogiri', '~> 1.8', '>= 1.8.5'
end
