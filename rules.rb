#!/usr/bin/env ruby

# A few helpful tips about the Rules file:
#
# * The order of rules is important: for each item, only the first matching
#   rule is applied.
#
# * Item identifiers start and end with a slash (e.g. "/about/" for the file
#   "content/about.html"). To select all children, grandchildren, ... of an
#   item, use the pattern "/about/*/"; "/about/*" will also select the parent,
#   because "*" matches zero or more characters.

compile '/static/css/*' do
  filter :sass, Compass.sass_engine_options
end

route '/static/css/_*' do
  # Don't output partials.
end

route '/static/css/*/' do
  @item.identifier.chop + '.css'
end

compile '/static/images/*/' do
  # Don't compile images.
end

route '/static/images/*/' do
  @item.identifier.chop + '.' + @item[:extension]
end

compile '/files/*/' do
  filter :erb
end

route '/files/*/' do
  @item.identifier.sub(/^\/files/, '').chop + '.' + @item[:extension]
end

compile '/dasblog/images/*/' do
end

compile '/dasblog/*/' do
  filter :relativize_paths, :type => :html
  layout 'default'
end

route '/dasblog/images/*/' do
  @item.identifier.sub(/^\/dasblog/, '/content/binary').chop + '.' + @item[:extension]
end

route '/dasblog/*/' do
  @item.slug + 'index.html'
end

compile '*' do
  filter :erb
  filter :kramdown
  filter :relativize_paths, :type => :html
  layout 'default'
end

route '*' do
  item.identifier + 'index.html'
end

layout '*', :haml, :attr_wrapper => '"'
