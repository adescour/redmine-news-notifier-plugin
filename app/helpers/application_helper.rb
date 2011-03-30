module ApplicationHelper
  def prompt_to_remote_extended(name, text, param, url, html_options = {})
    html_options[:onclick] = "promptToRemoteExtended('#{text}', '#{param}', '#{url_for(url)}'); return false;"
    link_to name, {}, html_options
  end

  def link_to_remote_extended(name, options = {}, html_options = nil)
    url = options[:url] || {}
    link_to_remote(name, options, html_options) 
  end

end
