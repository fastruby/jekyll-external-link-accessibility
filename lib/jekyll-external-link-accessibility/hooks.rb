require 'jekyll/hooks'
require 'jekyll-external-link-accessibility'

Jekyll::Hooks.register :posts, :post_render do |page|
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end

Jekyll::Hooks.register :pages, :post_render do |page|
  next if %w[.scss .json .xml].include?(page.extname)
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end
