require 'tools/Rake/ajaxmin'

class Minifier < Nanoc3::Filter
  identifier :minify
  type       :binary

  def run(filename, params = {})
    check_file_type filename

    Minify.javascript \
        :tool => configatron.tools.ajaxmin,
        :pretty => ! configatron.app.compress_output,
        :opts => ["-evals:safeall", "-silent"],
        :files => FileList.new(filename),
        :out_file => output_filename
  end

  def check_file_type(filename)
    ext = filename.pathmap("%x")
    case ext
    when /^\.css/
      "css"
    when /^\.js/
      "js"
    else
      raise "unknown type to minify '#{ext}' for '#{@item.raw_filename}'"
    end
  end
end
