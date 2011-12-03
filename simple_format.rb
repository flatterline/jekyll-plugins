module Jekyll
  module SimpleFormatFilter
    def simple_format(text)
      text = '' if text.nil?
      text = text.to_str

      text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
      text.gsub!(/\n\n+/, "</p>\n\n<p>")           # 2+ newline  -> paragraph
      text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br

      "<p>#{text}</p>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::SimpleFormatFilter)
