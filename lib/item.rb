class Nanoc3::Item
  def slug
    title && title.slug
  end
  
  def title
    self[:title] && !self[:title].empty? && self[:title]
  end
  
  def current?(item)
    item && item.path == self.path || false
  end
end