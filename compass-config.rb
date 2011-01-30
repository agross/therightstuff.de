output_style          = :compressed if configatron.app.compress_output
line_comments         = :false if configatron.app.compress_output
sass_options          = {
                          :cache_location => configatron.dir.tmp + "/sass-cache",
                          :debug_info => true
                        }

css_dir               = configatron.dir.site + "/static/css"
sass_dir              = "content/static/css"
images_dir            = "content/static/images"

http_path             = configatron.deployment.base_href
http_stylesheets_path = http_path + sass_dir.sub(/content\//, '')
http_images_path      = http_path + images_dir.sub(/content\//, '')