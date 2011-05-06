module Helpers
  module Blocks
    def markdown_block(content)
      Nanoc3::Filters::Kramdown.new.run(content)
    end
  end
end