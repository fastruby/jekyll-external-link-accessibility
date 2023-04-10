require 'jekyll-external-link-accessibility/hooks'
require 'nokogiri'

module Jekyll
  class ExternalLinkAccessibility
    def self.modify_links(page)
      config = page.site.config
      doc = Nokogiri::HTML.fragment(page.output)
      doc.css('.post-content a').each do |a|
        next if a['href'].nil? || a['href'].empty? || a['href'].start_with?('#') || a['data-no-external'] == 'true'

        if a['href'].start_with?('http')
          a['rel'] = external_link_rel(config: config) unless a['rel']
          a['target'] = external_link_target(config: config) unless a['target']
          a['title'] = external_link_title(config: config) unless a['title']
          a.add_child(" <i class='icon-external-link' aria-hidden='true'></i>")
          a.add_child(
            "<span
              style='overflow: hidden;clip: rect(0,0,0,0);
                    position: absolute !important;
                    width: 1px;
                    height: 1px;
                    border: 0;
                    word-wrap: normal !important;'>
              opens a new window
            </span>"
          )
        end
      end
      page.output = doc.to_html
    end

    def self.external_link_rel(config:)
      config.dig('external_links', 'rel') || 'external nofollow noopener noreferrer'
    end

    def self.external_link_target(config:)
      config.dig('external_links', 'target') || '_blank'
    end

    def self.external_link_title(config:)
      config.dig('external_links', 'title') || 'Opens a new window'
    end

    private_class_method :external_link_rel
    private_class_method :external_link_target
    private_class_method :external_link_title
  end
end
