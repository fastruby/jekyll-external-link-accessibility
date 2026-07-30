require 'jekyll-external-link-accessibility/hooks'
require 'nokogiri'
require 'uri'

module Jekyll
  class ExternalLinkAccessibility
    EXTERNAL_SCHEMES = %w[http:// https:// //].freeze

    def self.modify_links(page)
      config = page.site.config
      site_host = host_for(config['url'])
      doc = Nokogiri::HTML5(page.output)
      doc.css('.post-content a, .post-excerpt a').each do |a|
        next if a['href'].nil? || a['href'].empty? || a['href'].start_with?('#') || a['data-no-external'] == 'true'

        # Every link opens in a new tab so readers don't lose their place. Add the
        # icon and a screen-reader note so both sighted and screen-reader users know.
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

        # Only external links get the configured rel (nofollow, etc.) so we don't
        # pass our link equity to other sites.
        if external_link?(a['href'], site_host)
          a['rel'] = external_link_rel(config: config) unless a['rel']
        end
      end
      page.output = doc.to_html
    end

    # A link is external only when it points to a different host than the site.
    # Relative links ("/blog/..."), absolute links to our own domain and links to a
    # subdomain of it are internal, so they keep their link equity (no nofollow).
    def self.external_link?(href, site_host)
      return false unless href.start_with?(*EXTERNAL_SCHEMES)

      link_host = host_for(href)
      return true if link_host.nil?
      return false if site_host && link_host.end_with?(".#{site_host}")

      link_host != site_host
    end

    # Returns the lowercased host without a leading "www." so hosts match
    # regardless of case or www prefix.
    def self.host_for(url)
      host = URI.parse(url.to_s).host
      host&.downcase&.sub(/\Awww\./, '')
    rescue URI::InvalidURIError
      nil
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
