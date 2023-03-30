require 'nokogiri'

module Jekyll
  module ExternalLinkAccessibility
    class Generator < Jekyll::Generator
      def generate(site)
        site.posts.docs.each { |post| process_post(post) }
      end

      private

      def process_post(post)
        doc = Nokogiri::HTML.fragment(post.content)
        modify_links(doc)
        post.content = doc.to_html
      end

      def modify_links(doc)
        doc.css('a').each do |a|
          next if a['href'].nil? || a['href'].empty? || a['href'] == '#' || a['target'].nil?
          if a['href'].start_with?('http')
            a['rel'] = 'noreferrer noopener'
            a['data-type'] = 'URL'
            a['title'] = 'Opens a new window'
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
      end
    end
  end
end
