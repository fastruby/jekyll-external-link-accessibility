# frozen_string_literal: true

RSpec.describe Jekyll::ExternalLinkAccessibility do
  # Runs modify_links over a snippet wrapped in .post-content and hands back a
  # parsed document so specs can assert on the rewritten markup.
  def rewrite(inner_html, config: { 'url' => 'https://example.com' }, wrapper: 'post-content')
    html = "<html><body><div class='#{wrapper}'>#{inner_html}</div></body></html>"
    page = fake_page(html, config)
    described_class.modify_links(page)
    Nokogiri::HTML5(page.output)
  end

  describe '.host_for' do
    it 'downcases the host' do
      expect(described_class.host_for('https://Example.COM/path')).to eq('example.com')
    end

    it 'strips a leading www.' do
      expect(described_class.host_for('https://www.example.com')).to eq('example.com')
    end

    it 'returns nil for a blank or nil url' do
      expect(described_class.host_for(nil)).to be_nil
      expect(described_class.host_for('')).to be_nil
    end

    it 'returns nil on an invalid uri' do
      expect(described_class.host_for('http://[invalid')).to be_nil
    end
  end

  describe '.external_link?' do
    let(:site_host) { 'example.com' }

    it 'is true for another host over http, https or protocol-relative' do
      expect(described_class.external_link?('http://other.com', site_host)).to be(true)
      expect(described_class.external_link?('https://other.com', site_host)).to be(true)
      expect(described_class.external_link?('//other.com/page', site_host)).to be(true)
    end

    it 'is false for the same host, including the www variant' do
      expect(described_class.external_link?('https://example.com/blog', site_host)).to be(false)
      expect(described_class.external_link?('https://www.example.com/blog', site_host)).to be(false)
    end

    it 'is false for relative and anchor links' do
      expect(described_class.external_link?('/blog/post', site_host)).to be(false)
      expect(described_class.external_link?('#section', site_host)).to be(false)
    end

    it 'is true when the scheme matches but the host cannot be parsed' do
      expect(described_class.external_link?('http://[invalid', site_host)).to be(true)
    end
  end

  describe '.modify_links' do
    it 'rewrites anchors inside .post-content' do
      link = rewrite("<a href='https://other.com'>read</a>").at_css('.post-content a')

      expect(link['target']).to eq('_blank')
      expect(link['title']).to eq('Opens a new window')
      expect(link.at_css('i.icon-external-link')).not_to be_nil
      expect(link.text).to include('opens a new window')
    end

    it 'rewrites anchors inside .post-excerpt' do
      link = rewrite("<a href='https://other.com'>read</a>", wrapper: 'post-excerpt')
             .at_css('.post-excerpt a')

      expect(link['target']).to eq('_blank')
    end

    it 'leaves anchors outside those containers untouched' do
      html = "<html><body><nav><a href='https://other.com'>home</a></nav></body></html>"
      page = fake_page(html, 'url' => 'https://example.com')
      described_class.modify_links(page)
      link = Nokogiri::HTML5(page.output).at_css('nav a')

      expect(link['target']).to be_nil
      expect(link.at_css('i.icon-external-link')).to be_nil
    end

    it 'adds rel only to external links' do
      external = rewrite("<a href='https://other.com'>x</a>").at_css('a')
      internal = rewrite("<a href='https://example.com/blog'>x</a>").at_css('a')

      expect(external['rel']).to eq('external nofollow noopener noreferrer')
      expect(internal['rel']).to be_nil
    end

    it 'skips links with no href, empty href, anchors or data-no-external' do
      doc = rewrite(<<~HTML)
        <a>no href</a>
        <a href=''>empty</a>
        <a href='#top'>anchor</a>
        <a href='https://other.com' data-no-external='true'>opted out</a>
      HTML

      doc.css('.post-content a').each do |a|
        expect(a['target']).to be_nil
        expect(a.at_css('i.icon-external-link')).to be_nil
      end
    end

    it 'does not overwrite an existing target, title or rel' do
      link = rewrite(
        "<a href='https://other.com' target='_self' title='Keep me' rel='ugc'>x</a>"
      ).at_css('a')

      expect(link['target']).to eq('_self')
      expect(link['title']).to eq('Keep me')
      expect(link['rel']).to eq('ugc')
    end

    it 'honors config overrides for rel, target and title' do
      config = {
        'url' => 'https://example.com',
        'external_links' => {
          'rel' => 'nofollow',
          'target' => '_top',
          'title' => 'External site'
        }
      }
      link = rewrite("<a href='https://other.com'>x</a>", config: config).at_css('a')

      expect(link['rel']).to eq('nofollow')
      expect(link['target']).to eq('_top')
      expect(link['title']).to eq('External site')
    end
  end
end
