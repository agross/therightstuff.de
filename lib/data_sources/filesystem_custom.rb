class CustomDataSource < Nanoc3::DataSources::FilesystemUnified
  identifier :filesystem_custom
  
  def setup
    # Create directories
    %w( @config[:path] ).each do |dir|
      FileUtils.mkdir_p(dir)
      vcs.add(dir)
    end
  end
  
  # See {Nanoc3::DataSource#items}.
  def items
    load_objects(@config[:path], 'item', Nanoc3::Item)
  end
end