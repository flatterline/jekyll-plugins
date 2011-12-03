# Jekyll Plugins

This is a collection of plugins for the Jekyll static site generator. You can see these plugins in use on the [flatterline.com](http://flatterline.com) website.

## Overview

This repository includes the following plugins:

*   **portfolio.rb** - A plugin for generating a portfolio page and individual 
    project pages.

*   **read_more.rb** - A plugin for generating a link to read more for post 
    index pages.

*   **simple_format.rb** - A plugin for formatting a block of text very 
    simply.

*   **team.rb** - A plugin for generating a team page, individual profile 
    pages and a Liquid filter for short author bios on blog posts.

## Usage

### Company Portfolio

Need to create a portfolio page for your company website? Look no further!

Simply define data files in the `_projects` directory and this plugin will read those, create a portfolio index and a page for each project. Then all you need to do is style them :)

See the sample pages for possible layouts and data file format:

*   [_layouts/portfolio.html](https://github.com/flatterline/jekyll-plugins/blob/master/_layouts/portfolio.html)

*   [_layouts/project.html](https://github.com/flatterline/jekyll-plugins/blob/master/_layouts/project.html)

*   [_projects/sample-project.yml](https://github.com/flatterline/jekyll-plugins/blob/master/_projects/sample-project.yml)

### Read More for Blog Posts

This is a very simple Liquid Template filter to create a nofollow, "read more" link for blog posts. It is intended to be used on blog index pages after an excerpt. For example:

`{% if post.excerpt %}
  {{ post.excerpt | read_more: post.url }}
{% endif %}`

might produce something like:

`This is our custom blog post excerpt.<a href="/blog/2011/01/01/a-blog-post" rel="nofollow" class="read-more">read more »</a>`

**Note:** For SEO purposes you should always have a unique excerpt for each post that is used on the index page.

### Simple Format

This is a very simple Liquid Template filter to mimic the Rails simple_format method. It will perform the following transformations:

*   \r\n and \r -> \n
*   2+ newline  -> paragraph
*   1 newline   -> br

Using our example from before:

`{% if post.excerpt %}
  {{ post.excerpt | read_more: post.url | simple_format }}
{% endif %}`

might produce something like:

`<p>This is our custom blog post excerpt.<a href="/blog/2011/01/01/a-blog-post" rel="nofollow" class="read-more">read more »</a></p>`

### Company Team

Need to create a team page for your company website? Look no further!

Simply define data files in the `_team` directory and this plugin will read those, create a team index and a page for each team member. Then all you need to do is style them :)

See the sample pages for possible layouts and data file format:

*   [_layouts/team.html](https://github.com/flatterline/jekyll-plugins/blob/master/_layouts/team.html)

*   [_layouts/profile.html](https://github.com/flatterline/jekyll-plugins/blob/master/_layouts/profile.html)

*   [_team/sample-person.yml](https://github.com/flatterline/jekyll-plugins/blob/master/_team/sample-person.yml)

This plugin also includes a Liquid Template tag for an author bio to include on a blog post page. Add an author to your YAML Front Matter for each post, like so:

`author: Sample Person`

Then use the tag on your post layout:

`{% authors %}`

**Note:** The author name will be converted to the YML file name, so the file names need to follow a format that you use for your author names. The general formula is:

*   Convert author to downcase
*   Replace all spaces with dashes
*   Append .yml

e.g., Sample Person -> sample-person.yml

## Requirements

*   Ruby >= 1.9.2

## Note on Patches/Pull Requests

Did we miss something? Is there a bug?
 
*   Fork the project.
*   Make your feature addition or bug fix.
*   Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
*   Send us a pull request.

## Author

Written by [Curtis Miller](http://millarian.com) of Flatterline, a [Ruby on Rails development company](http://flatterline.com).

## Copyright

Copyright (c) 2011 Flatterline LLC. See LICENSE for details.
