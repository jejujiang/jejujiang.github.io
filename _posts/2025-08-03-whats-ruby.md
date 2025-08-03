---
title: What's Ruby?
---

<p class="lead"><a href="https://www.ruby-lang.org">Ruby</a> is a dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write. </p>

Form [the project's readme:](https://github.com/ruby/ruby/blob/30a20bc166bc37acd7dcb3788686df149c7f428a/README.md#L4)
> Ruby is an interpreted object-oriented programming language often used for web development. It also offers many scripting features to process plain text and serialized files, or manage system tasks. It is simple, straightforward, and extensible.

It’s a programmer's best friend. Find out more by [visiting the project on GitHub](https://github.com/ruby/ruby).

```ruby
# The Greeter class
class Greeter
  def initialize(name)
    @name = name.capitalize
  end

  def salute
    puts "Hello #{@name}!"
  end
end

# Create a new object
g = Greeter.new("world")

# Output "Hello World!"
g.salute
```
