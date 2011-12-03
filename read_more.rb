module Jekyll
  module ReadMoreFilter
    def read_more(text, url)
      text = '' if text.nil?
      text = text.to_str

      "#{text}<a href=\"#{url}\" rel=\"nofollow\" class=\"read-more\">read more &raquo;</a>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::ReadMoreFilter)
