require 'rubygems'
require 'pygments/c'
require 'redcarpet'

module Scanty
    class XHTMLwithPygments < Redcarpet::Render::XHTML
        def block_code(code, language)
            Pygments::C.highlight(code, :lexer => language)
        end
    end
    
    @markdown_renderer = XHTMLwithPygments.new(:filter_html => false, :no_images => false,
                :no_links => false, :no_styles => false, :safe_links_only => false,
                :with_toc_data => false, :hard_wrap => false, :xhtml => true)
    @markdown = Redcarpet::Markdown.new(@markdown_renderer, :no_intra_emphasis => true,
                :tables => true, :fenced_code_blocks => true, :autolink => true,
                :strikethrough => true, :lax_html_blocks => true, :space_after_headers => true,
                :superscript => true)
    
    def self.markdown(text)
        @markdown.render(text)
    end
end