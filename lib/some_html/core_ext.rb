String.class_eval do
  # Converts all not allowd HTML special symbols (&,<,>) to HTML entities
  # The function allows following HTML:
  #    <a href="URL"> link </a> (only href attribute)
  #    <b>bold</b>
  #    <blockquote>
  #        blockquote
  #    </blockquote>
  #    <em>emphasis</em>
  #    <i>italic</i>
  #    <strong>strong</strong>
  #    <u>underlined</u>
  #    <hX>Heading X</hX>
  #    <p>paragrafs</p>
  #    <br />
  #    HTML entities: &nbsp; &gt; &lt; &amp;
  def some_html
    # catching nil error for text phrasing
    return nil if self.nil?

    # converting newlines 
    s = self.gsub(/\r\n?/, "\n") 
 
    # escaping HTML to entities 
    s = s.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;') 
 
    # blockquote tag support 
    s.gsub!(/\n?&lt;blockquote&gt;\n*(.+?)\n*&lt;\/blockquote&gt;/im, "<blockquote>\\1</blockquote>") 
 
    # other tags: b, i, em, strong, u 
    %w(b i em strong u h[1-6] p).each { |x|
         s.gsub!(Regexp.new('&lt;('+x+')&gt;(.+?)&lt;/('+x+')&gt;',
                 Regexp::MULTILINE|Regexp::IGNORECASE), 
                 "<\\1>\\2</\\1>")
        } 
 
    # A tag support 
    # href="" attribute auto-adds http:// 
    s = s.gsub(/&lt;a.+?href\s*=\s*['"](.+?)["'].*?&gt;(.+?)&lt;\/a&gt;/im) { |x|
            '<a href="' + ($1.index('://') ? $1 : 'http://'+$1) + "\">" + $2 + "</a>" 
          }
 
    # replacing newlines to <br> and <p> tags 
    # wrapping text into paragraph 
    # only if no p or br tags are found and there are line brakes
    if s.match(/\n/) && !(s.include?("&lt;p&gt;") || s.include?("&lt;br /&gt;"))
      s = '<p>' + s.gsub(/\n\n+/, "</p>\n\n<p>") + '</p>'
      s.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />')
    end

    # unescape <br />
    s = s.gsub("&lt;br /&gt;", "<br />")

    # unescape HTML entities: nbsp gt lt amp
    %w(nbsp gt lt amp).each{ |x|
      s.gsub!('&amp;'+x+';','&'+x)
    } 
    
    s.html_safe   
  end 
end
