require 'cgi'
require 'stringex'

class Nanoc3::Item
  def slug
    title && "/#{self[:created_at].strftime("%Y/%m/%d")}/#{title.to_url}/"
  end
  
  def title
    self[:title] && !self[:title].empty? && self[:title]
  end
  
  def current?(item)
    item && item.path == self.path || false
  end
  
  def dasblog
    slug = title.gsub(/[#%";\/?:@&=$-\."!]/, '')
    slug = CGI::escape slug
    slug = slug.gsub(/;/, '').gsub(/\+/, '-')
    slug = CGI::unescape slug
    
    {
      :guid => self[:guid],
      :slug => "/#{self[:created_at].strftime("%Y/%m/%d")}/#{slug}.aspx"
    }
  end
end