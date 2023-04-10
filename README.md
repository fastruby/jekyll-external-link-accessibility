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
The plugin automatically edits all links on all posts. You can however skip the check on some links, by adding `<a href="...." data-no-external="true">...</a>` to the link.

### Configuration
You can override the default configuration by adding the following section to your Jekyll site's `_config.yml`:

```yaml
external_links:
  rel: external nofollow noopener noreferrer
  target: _blank
  title: Opens a new window
```

### Styling
Next to each external link is an icon for external links with a `icon-external-link` class name. You need to have the styles in your project. For example, we use icomoon for icons:

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
