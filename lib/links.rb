module Helpers
  module Links
    def link(identifier, attributes = {})
      item = @items.find { |i| i.identifier == identifier }
      raise "Item to link not found: #{identifier}" unless item
      
      link_text = item[:title] || 'NO TITLE'
      
      attrs = []
      attrs << { :style => "color: red; font-weight: bold" } unless item.title
      attrs << { :title => item.long_title } if item.long_title
      attrs << { :class => "active" } if item.current?(@item)
      
      attrs = Hash[*attrs.collect {|h| h.to_a}.flatten] 
      attrs.merge! attributes
      
      link_to link_text, relative_path_to(item), attrs || {}
    end
    
    def current_index(identifiers)
      items = identifiers.map do |i|
          @items.find { |item| item.identifier == i }
      end
      
      raise "Could not find one or more items for these identifiers: #{identifiers.join ' '}" if items.include? nil
      
      index = items.find_index do |item|
        item.current? @item
      end
      
      index || "none"
    end
  end
end