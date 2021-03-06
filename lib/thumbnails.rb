class Thumbnailize < Nanoc3::Filter
  identifier :thumbnailize
  type       :binary

  def run(filename, params={})
    system(
      'tools/ImageMagick/convert.exe',
      '-resize',
      params[:width].to_s,
      filename,
      output_filename
    )
  end
end
