class String
  def slug
    self.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end