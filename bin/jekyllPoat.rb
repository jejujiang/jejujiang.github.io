#!/usr/bin/env ruby

require 'optparse'
require 'date'

# 默认选项
options = {
  title: "新文章",
  layout: "post",
  date: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z"),
  categories: [],
  tags: [],
  output_dir: "_posts"
}

# 解析命令行参数
OptionParser.new do |opts|
  opts.banner = "用法: jekyll-post [选项]"

  opts.on("-t", "--title TITLE", "文章标题") do |t|
    options[:title] = t
  end

  opts.on("-l", "--layout LAYOUT", "布局类型") do |l|
    options[:layout] = l
  end

  opts.on("-d", "--date DATE", "发布日期") do |d|
    options[:date] = d
  end

  opts.on("-c", "--categories x,y,z", Array, "分类列表") do |c|
    options[:categories] = c
  end

  opts.on("--tags x,y,z", Array, "标签列表") do |t|
    options[:tags] = t
  end

  opts.on("-o", "--output DIR", "输出目录") do |o|
    options[:output_dir] = o
  end

  opts.on("-h", "--help", "显示帮助") do
    puts opts
    exit
  end
end.parse!

# 生成文件名
filename = "#{options[:output_dir]}/#{DateTime.now.strftime("%Y-%m-%d")}-#{options[:title].downcase.gsub(/\s+/, '-').gsub(/[^\w-]/, '')}.md"

# 生成 Front Matter
front_matter = <<~YAML
  ---
  layout: #{options[:layout]}
  title: "#{options[:title]}"
  date: #{options[:date]}
  YAML

unless options[:categories].empty?
  front_matter += "categories: #{options[:categories].inspect}\n"
end

unless options[:tags].empty?
  front_matter += "tags: #{options[:tags].inspect}\n"
end

front_matter += "---\n\n"

# 写入文件
File.open(filename, 'w') do |file|
  file.write(front_matter)
end

puts "已创建新文章: #{filename}"
