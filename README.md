# blog.greghale.io

Personal blog built with [Zola](https://www.getzola.org/) static site generator and the [PaperMod](https://github.com/cydave/zola-theme-papermod) theme.

## Setup

This project uses Nix for dependency management. To get started:

```bash
nix-shell
```

This will provide you with Zola and all necessary tools.

## Development

To run the development server:

```bash
zola serve
```

The site will be available at `http://127.0.0.1:1111`

## Building

To build the static site:

```bash
zola build
```

The generated site will be in the `public/` directory.

## Content Structure

- `content/posts/` - Blog posts
- `static/` - Static assets (images, js, css, data files)
- `templates/` - Custom template overrides
- `themes/papermod/` - PaperMod theme (git submodule)

## Writing Posts

Posts are written in Markdown and placed in `content/posts/`. Each post should have frontmatter like:

```markdown
+++
title = "Post Title"
description = "Short description"
date = 2025-01-01

[taxonomies]
tags = ["tag1", "tag2"]
+++

Your content here...
```

## Deployment

The site is configured to deploy to `blog.greghale.io`. After building with `zola build`, the contents of the `public/` directory should be deployed to your hosting provider.

## Theme

This blog uses the PaperMod theme for Zola, which provides:
- Light/Dark theme toggle
- Fast and responsive design
- Code syntax highlighting
- RSS feeds
- Tag support
- Search functionality

Theme documentation: https://github.com/cydave/zola-theme-papermod
