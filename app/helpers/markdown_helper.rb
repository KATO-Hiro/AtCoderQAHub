# See:
# https://github.com/vmg/redcarpet
# https://github.com/rubychan/coderay

# https://programming-beginner-zeroichi.jp/articles/57
# https://qiita.com/hkengo/items/978ea1874cf7e07cdbfc
# https://azarashi-blogs.com/2019-02-22-011403/
module MarkdownHelper
  require "redcarpet"
  require "coderay"

  class HTMLwithCoderay < Redcarpet::Render::HTML
    # FIXME: Some input causes error
    def block_code(code, language)
      language = language.split(':')[0]

      # Detect language
      case language.to_s
        when 'py'
          lang = 'python'
        when 'rb'
          lang = 'ruby'
        when 'yml'
          lang = 'yaml'
        when 'html'
          lang = 'html'
        when ''
          lang = 'md'
        else
          lang = language
      end

      CodeRay.scan(code, lang).div
    end
  end

  # Usage:
  # <%= sanitize(markdown(@hoge.content).html_safe, tags: %w(h1 h2 h3 h4 h5 strong em a p), attributes: %w(href)) %>
  # See:
  # https://qiita.com/ei-ei-eiichi/items/0c2bb126b858a62a39e5#_reference-2ce417a04348e6eb4d90
  def markdown(content)
    html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)

    options = {
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true,
      tables: true,
      hard_wrap: true,
      lax_html_blocks: true,
      strikethrough: true
    }

    markdown = Redcarpet::Markdown.new(html_render, options)
    markdown.render(content)
  end
end