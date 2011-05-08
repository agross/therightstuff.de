require 'nokogiri'

module Helpers
  module WebConfig
    def dasblog_rewrite_map(map_name)
      builder = Nokogiri::XML::Builder.new(:encoding => "UTF-8") do |xml|
        xml.rewriteMap(:name => map_name) {
          dasblog_items.each do |item|
            xml.add(:key => yield(item), :value => item.slug)
          end
        }
      end
      
      xml_without_pi builder
    end

    def dasblog_rewrite_guids(using_map_name)
      doc = Nokogiri::XML::DocumentFragment.parse ""
      builder = Nokogiri::XML::Builder.with(doc) do |xml|
        redirect "Comment view pages", "^CommentView,guid,(.*).aspx", "\{#{using_map_name}:\{R:1}}", xml
        redirect "Permalink pages", "^Permalink,guid,(.*).aspx", "\{#{using_map_name}:\{R:1}}", xml
      end
      
      doc.to_xml
    end
    
    def dasblog_rewrite_slugs(using_map_name)
      doc = Nokogiri::XML::DocumentFragment.parse ""
      builder = Nokogiri::XML::Builder.with(doc) do |xml|
        redirect "Content pages", ".*", "\{#{using_map_name}:\{REQUEST_URI}}", xml
      end
      
      doc.to_xml
    end
    
    def redirect(name, pattern, match, xml)
      xml.rule(:name => name, :enabled => true, :stopProcessing => true) {
        xml.match :url => pattern
        xml.conditions(:logicalGrouping => "MatchAll", :trackAllCaptures => false) {
          xml.add :input => match, :pattern => '(.+)'
        }
        xml.action :type => "Redirect", :redirectType => "Permanent", :url => '{C:1}'
      }
    end
    
    def dasblog_items
      @items.select { |i| i[:guid] }
    end
    
    # HACK: We need an UTF-8 encoded document fragment, that we won't get unless we specify the encoding on the document
    # which in turn causes the processing instruction to be generated (that breaks our web.config).
    def xml_without_pi(xml)
      xml.to_xml.sub(/^<\?xml.*\n/, '')
    end
  end
end