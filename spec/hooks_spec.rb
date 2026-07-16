# frozen_string_literal: true

RSpec.describe 'pages :post_render hook' do
  # Fires the registered hook for a page with the given extension and reports
  # whether the rewriter ran.
  def trigger(extname)
    page = fake_page('<html><body></body></html>', 'url' => 'https://example.com')
    page.define_singleton_method(:extname) { extname }
    Jekyll::Hooks.trigger(:pages, :post_render, page)
  end

  before do
    allow(Jekyll::ExternalLinkAccessibility).to receive(:modify_links)
  end

  it 'rewrites html pages' do
    trigger('.html')
    trigger('.htm')

    expect(Jekyll::ExternalLinkAccessibility).to have_received(:modify_links).twice
  end

  it 'skips non-html pages so xml/json/txt are not corrupted' do
    trigger('.xml')
    trigger('.json')
    trigger('.txt')

    expect(Jekyll::ExternalLinkAccessibility).not_to have_received(:modify_links)
  end
end
