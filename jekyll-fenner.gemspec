# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "jekyll-fenner"
  spec.version       = "0.1.0"
  spec.authors       = ["Neil D. Lawrence"]
  spec.email         = ["ndl21@cam.ac.uk"]

  spec.summary       = "Shared Jekyll layouts and includes for scholarly publication pages, citations, and paper SEO."
  spec.description   = <<~DESC
    Fenner extracts the publication, citation, and paper SEO template core used
    across lawrennd/mlatcl/mlresearch Jekyll themes so org themes can stay thin
    brand shells. Named in honour of Martin Fenner's CiteProc-oriented citation
    presentation work.
  DESC
  spec.homepage      = "https://github.com/lawrennd/jekyll-fenner"
  spec.license       = "MIT"

  spec.metadata["plugin_type"] = "theme"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = `git ls-files -z`.split("\x0").select do |f|
    f.match(%r!^(assets|_(includes|layouts)/|(LICENSE|README)((\.(txt|md|markdown)|$)))!i)
  end

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_runtime_dependency "jekyll", ">= 3.5", "< 5.0"
end
