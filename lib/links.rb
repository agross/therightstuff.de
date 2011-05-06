module Helpers
  module Links
    def link(identifier, attributes = {})
      item = @items.find { |i| i.identifier == identifier }
      raise "Item to link not found: #{identifier}" unless item
      
      link_text = attributes[:title] || item[:title] || 'NO TITLE'
      
      attrs = []
      attrs << { :style => "color: red; font-weight: bold" } unless item.title
      attrs << { :title => item.long_title } if item.long_title
      attrs << { :class => "active" } if item.current?(@item)
      
      attrs = Hash[*attrs.collect {|h| h.to_a}.flatten] 
      attrs.merge! attributes
      
      link_to link_text, relative_path_to(item), attrs || {}
    end
    
    def link_url(identifier)
      item = @items.find { |i| i.identifier == identifier }
      raise "Item to link not found: #{identifier}" unless item
      
      relative_path_to item
    end
    
    def title_of(identifier)
      item = @items.find { |i| i.identifier == identifier }
      raise "Item to link not found: #{identifier}" unless item
      
      item[:title] || 'NO TITLE'
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

    def photo_url(identifier)
      item = image identifier

      item.path
    end

    def thumbnail_url(identifier)
      item = image identifier

      item.path :rep => :thumbnail
    end
    
    def image(identifier)
      photos_root = configatron.app.photos_root
      item = @items.find { |i| i.identifier == photos_root + identifier + "/" }

      raise "Photo to link not found: #{identifier}" unless item
      raise "Item is not a binary file: #{identifier}" unless item.binary?

      item
    end
  end
end