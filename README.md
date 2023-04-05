# Jekyll External Link Accessibility

This plugin adds `rel`, `title`, `new tab icon` and `target` to all external links in your blog post.

## Setup

1. Add the gem to your `Gemfile`:
    ```ruby
    gem 'jekyll-external-link-accessibility', github: 'fastruby/jekyll-external-link-accessibility'
    ```
2. Run `bundle install` to install the gem
3. Add the following to your `_config.yml`:
    ```yaml
    plugins:
      - jekyll-external-link-accessibility
    ```

## Usage

### Configuration

You can override the default configuration by adding the following section to your Jekyll site's `_config.yml`:

```yaml
external_links:
  rel: external nofollow noopener noreferrer
  target: _blank
  title: Opens a new window
  exclude:
    - https://www.facebook.com/sharer/.+
    - http://twitter.com/share?.+
```

#### Default Configuration
| Key | Default Value | Description |
| ---------------------------- | ---------------------------- | -------------------------------------------------- |
| `external_links.rel`     | `external nofollow noopener noreferrer` | The `rel` attribute to add to external links.      |
| `external_links.target`  | `_blank`                     | The `target` attribute to add to external links.   |
| `external_links.exclude` | `[]`                         | A list of URLs to exclude from processing.         |
