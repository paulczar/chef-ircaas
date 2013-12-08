# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'chef' do
  watch(%r{^cookbooks/(.+)/})
  watch(%r{^roles/(.+).rb})
  watch(%r{^data_bags/(.+)/})
end

