class DasBlogDataSource < Nanoc3::DataSource
  include Nanoc3::DataSources::Filesystem
  
  identifier :dasblog
  
  @@ns = { 'db' => 'urn:newtelligence-com:dasblog:runtime:data' }
  
  def setup
    # Create directories
    %w( @config[:path] ).each do |dir|
      FileUtils.mkdir_p(dir)
      vcs.add(dir)
    end
  end
  
  def items
    @items ||= begin
        require 'nokogiri'
        require 'date'
        require 'time'
        
        all_split_files_in(@config[:path]).map do |base_filename, (meta_ext, content_ext)|
          doc = Nokogiri::XML(open(filename_for(base_filename, content_ext)))
          
          entries = doc.xpath '//db:Entry', @@ns
          entries.map do |entry|
              parse_entry entry, filename_for(base_filename, content_ext)
          end
        end
      end
    
    # Need to flatten because there might be > 1 entry for a particular day.
    @items.flatten
  end
  
  def layouts
    # No layouts to find here, please move on.
    []
  end
  
  # See {Nanoc3::DataSources::Filesystem#filename_for}.
  def filename_for(base_filename, ext)
    if ext.nil?
      nil
    elsif ext.empty?
      base_filename
    else
      base_filename + '.' + ext
    end
  end
  
  private
  def identifier_for(attributes)
    @items_root + attributes[:created_at].strftime("%Y/%m/%d/") + attributes[:title].slug
  end
  
  def parse_entry(entry, filename)
    content = entry.xpath 'db:Content', @@ns
    created_at = entry.xpath 'db:Created', @@ns
    modified_at = entry.xpath 'db:Modified', @@ns
    guid = entry.xpath 'db:EntryId', @@ns
    title = entry.xpath 'db:Title', @@ns
    tags = entry.xpath 'db:Categories', @@ns
    
    attributes = {
      :kind        => 'article',
      :created_at  => DateTime.parse(created_at.text),
      :updated_at  => DateTime.parse(modified_at.text),
      :guid        => guid.text,
      :title       => title.text,
      :tags        => tags.text.split(';')
    }
    
    identifier = identifier_for attributes
    mtime = Time.parse attributes[:modified_at].to_s
    Nanoc3::Item.new content.text, attributes, identifier, mtime
  end
end
