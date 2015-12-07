require 'rails'
require 'rouge/plugins/redcarpet'

class AjisaiMarkdown < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end


class AjisaiMarkdowner

  def self.md(str)
    return '' if str.blank?
    markdown = Redcarpet::Markdown.new(AjisaiMarkdown, {
        autolink: true,
        fenced_code_blocks: true,
        strikethrough: true,
        space_after_headers: false,
        disable_indented_code_blocks: true,
        no_intra_emphasis: true
      })

    markdown.render(str)
  end

end
