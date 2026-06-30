require 'jekyll/hooks'
require 'jekyll-external-link-accessibility'

Jekyll::Hooks.register :posts, :post_render do |page|
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end

Jekyll::Hooks.register :pages, :post_render do |page|
  # Only rewrite HTML pages. Running the HTML parser over .xml (rss/sitemap),
  # .json, .txt, etc. would wrap them in <html><body> and corrupt them.
  next unless ['.html', '.htm'].include?(page.extname)
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end
