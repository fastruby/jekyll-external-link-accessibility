# Jekyll External Link Accessibility

This plugin makes every link in your blog posts open in a new tab accessibly (`target`, `title`, a new-tab icon, and a screen-reader note), and adds `rel="nofollow"` to external links.

## Setup

1. Add the gem to your `Gemfile`:
    ```ruby
    gem 'jekyll-external-link-accessibility'
    ```
2. Run `bundle install` to install the gem
3. Add the following to your `_config.yml`:
    ```yaml
    plugins:
      - jekyll-external-link-accessibility
    ```

## Usage
The plugin edits every link in a post, internal and external:

- All links open in a new tab so readers don't lose their place, with a `title`, a new-tab icon, and a screen-reader-only "opens a new window" note. Skip a specific link by adding `data-no-external="true"`, e.g. `<a href="...." data-no-external="true">...</a>`.
- External links (pointing to a host other than your site's `url` in `_config.yml`) also get a `rel` attribute (`external nofollow noopener noreferrer` by default, see Configuration). The `nofollow` keeps them from passing your link equity off-site, so internal links are left without a `rel`. The `www.` prefix and host casing are ignored when comparing hosts.

### Configuration
You can override the default configuration by adding the following section to your Jekyll site's `_config.yml`:

```yaml
external_links:
  rel: external nofollow noopener noreferrer
  target: _blank
  title: Opens a new window
```

### Styling
Next to each link is a new-tab icon with a `icon-external-link` class name. You need to have the styles in your project. For example, we use icomoon for icons:

```css
.icon-external-link:before {
  content: "\ea7e";
}
```
#### Default Configuration
| Key | Default Value | Description |
| ---------------------------- | ---------------------------- | -------------------------------------------------- |
| `external_links.rel`     | `external nofollow noopener noreferrer` | The `rel` attribute to add to external links.      |
| `external_links.target`  | `_blank`                     | The `target` attribute to add to external links.   |
| `external_links.title`  | `Opens a new window`                     | The `title` attribute to add title to links.   |

## Steps to release a new version

We follow [Semantic Versioning](https://semver.org/): bump MAJOR for incompatible changes, MINOR for backwards-compatible features, and PATCH for backwards-compatible bug fixes.

1. Update the version in `lib/jekyll-external-link-accessibility/version.rb`
2. Update `CHANGELOG.md`: move the `main (unreleased)` entries under a new `vX.Y.Z / YYYY-MM-DD` header
3. Push a `release/vX.Y.Z` branch with those changes
4. Open a pull request titled "Release vX.Y.Z" and merge it to `main`
5. Tag the release and push the tag:
    ```bash
    git checkout main && git pull
    git tag vX.Y.Z
    git push --tags
    ```
6. Build the gem:
    ```bash
    gem build jekyll-external-link-accessibility.gemspec
    ```
7. Push it to RubyGems:
    ```bash
    gem push jekyll-external-link-accessibility-X.Y.Z.gem
    ```
