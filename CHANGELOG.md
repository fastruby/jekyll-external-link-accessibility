# main [(unreleased)](https://github.com/fastruby/jekyll-external-link-accessibility/compare/v0.2.0...main)

- [CHORE: Add an RSpec test suite and CI matrix running Ruby 2.7 through 4.0](https://github.com/fastruby/jekyll-external-link-accessibility/pull/6)

# v0.2.0 / 2026-07-15 [(commits)](https://github.com/fastruby/jekyll-external-link-accessibility/compare/v0.1.0...v0.2.0)

- [FEATURE: Detect external links by host instead of URL prefix, ignoring the `www.` prefix and host casing](https://github.com/fastruby/jekyll-external-link-accessibility/pull/4)
- [FEATURE: Open internal links in a new tab too, without adding `rel="nofollow"`](https://github.com/fastruby/jekyll-external-link-accessibility/pull/4)
- [FEATURE: Show the new-tab icon on all links, not just external ones](https://github.com/fastruby/jekyll-external-link-accessibility/pull/4)

# v0.1.0

- [FEATURE: Add accessibility attributes (`target`, `title`, new-tab icon, screen-reader note) and `rel="nofollow"` to external links in blog posts](https://github.com/fastruby/jekyll-external-link-accessibility/commit/cbc17d840038fa932f4c1f2f153b885a659fa69e)
- [FEATURE: Add a `data-no-external` attribute to skip individual links](https://github.com/fastruby/jekyll-external-link-accessibility/commit/49c4721)
- [FEATURE: Add `post-excerpt` class links to the accessibility code](https://github.com/fastruby/jekyll-external-link-accessibility/pull/1)
- [BUGFIX: Skip `scss` and `json` files in the hook](https://github.com/fastruby/jekyll-external-link-accessibility/pull/2)
- [BUGFIX: Skip `xml` files in the hook](https://github.com/fastruby/jekyll-external-link-accessibility/pull/3)
