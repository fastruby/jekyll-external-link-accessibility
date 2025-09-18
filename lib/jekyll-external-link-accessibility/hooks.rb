require 'jekyll/hooks'
require 'jekyll-external-link-accessibility'

Jekyll::Hooks.register :posts, :post_render do |page|
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end

Jekyll::Hooks.register :pages, :post_render do |page|
  next if page.extname == '.scss' || page.extname == '.json'
  Jekyll::ExternalLinkAccessibility.modify_links(page)
end
