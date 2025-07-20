#!/usr/bin/env ruby

require 'optparse'
require 'date'

options = {
  title: nil,
  layout: "post",
  date: DateTime.now.strftime("%Y-%m-%d %H:%M:%S %z"),
  categories: [],
  tags: [],
  output_dir: "_posts",
  editor: ENV['EDITOR'] || 'vi'  # 使用环境变量中的编辑器或默认vi
}

OptionParser.new do |opts|
  opts.banner = "用法: jekyll-post [选项]"

  opts.on("-t", "--title TITLE", "文章标题（必填）") do |t|
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

  opts.on("-e", "--editor EDITOR", "指定编辑器（默认: vi）") do |e|
    options[:editor] = e
  end

  opts.on("--no-edit", "不自动打开编辑器") do
    options[:editor] = nil
  end

  opts.on("-h", "--help", "显示帮助") do
    puts opts
    exit
  end
end.parse!

# 验证必填参数
unless options[:title]
  puts "错误：必须指定文章标题"
  puts "示例: jekyll-post -t \"我的文章标题\""
  puts "使用 -h 查看完整帮助"
  exit 1
end

# 创建输出目录（如果不存在）
Dir.mkdir(options[:output_dir]) unless Dir.exist?(options[:output_dir])

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

# 使用编辑器打开文件
if options[:editor]
  system("#{options[:editor]} #{filename}")
  if $?.success?
    puts "已在 #{options[:editor]} 中打开文件"
  else
    puts "警告：无法打开编辑器 #{options[:editor]}"
    puts "请尝试设置 EDITOR 环境变量或使用 -e 选项指定编辑器"
  end
end
