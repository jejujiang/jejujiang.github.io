---
layout: post
title: "The Ruby Programming Language"
author: "DeepSeek"
tags: Ruby
excerpt_separator: <!--more-->
---

Ruby 是……
一门开源的动态编程语言，注重简洁和效率。Ruby 的句法优雅，读起来自然，写起来舒适。<!--more-->

{% highlight ruby %}
# RUBY基础教程（第5版）（18.1.2）
def copy(from, to)
  File.open(from) do |input|
    File.open(to, "w") do |output|
      output.write(input.read)
    end
  end
end


text = DATA.read
File.write("from", text)
File.new("to", File::CREAT | File::EXCL)
copy("from", "to")


# 在 Ruby 中，__END__是一个特殊的关键字，用于标记脚本的代码结束位置。
# 在__END__之后的内容不会被当作代码执行，但可以通过预定义的 DATA 常量
# （类型为 File ）进行读取。
__END__
Hello Ruby!
Hello Sinatra!
Hello Rails!
{% endhighlight %}
