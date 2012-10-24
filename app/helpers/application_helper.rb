module ApplicationHelper
  def data_link(text, format = :html)
    link = url_for :controller => "data", :action => "index", :format => format

    return link_to text, link
  end
end
