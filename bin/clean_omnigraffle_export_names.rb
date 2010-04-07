#!/usr/bin/ruby -w

# 
# Use this to rename the files exported from omni outliner
# Converts WF_1_1-Woot_Woot.jpg => WF.1.1_-Woot_Woot.jpg
# 

require 'fileutils'

unless ARGV[0]
  puts <<-USAGE
Cleans the file names from omnigraffle so their a little prettier.

Usage:
clean_omnigraffle_export_names.rb [assets_dir]
  USAGE
end

asset_dir = File.expand_path(ARGV[0])

Dir["#{asset_dir}/*"].each do |f|
  filename = File.basename(f)
  filename.scan(/^([A-Z]+(?:\_\d)+)/) do |m|
    new_id = "#{m.to_s.gsub('_', '.')}_"
    FileUtils.mv(f, "#{asset_dir}/#{filename.gsub(m.to_s, new_id)}")
  end 
end