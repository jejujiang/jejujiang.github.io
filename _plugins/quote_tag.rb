# _plugins/quote_tag.rb
module Jekyll
  class QuoteTag < Liquid::Tag
    def render(context)
      # 从 _data/quotes.yml 获取数据
      quotes = context.registers[:site].data['quotes']
      # 计算每日索引（按年日）
      index = (Date.today.yday - 1) % quotes.size
      quote = quotes[index]
      "<blockquote>#{quote['quote']}<footer>— #{quote['author']}</footer></blockquote>"
    end
  end
end

Liquid::Template.register_tag('daily_quote', Jekyll::QuoteTag)
