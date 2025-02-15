---
---
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		    <meta charset="UTF-8">
		        <meta name="viewport" content="width=device-width, initial-scale=1.0">
			    <title>简约风格主页</title>
			        <link rel="stylesheet" href="/assets/css/styles.css">
	</head>
	<body>
		    <header>
			            <nav>
					                <ul>
								                <li><a href="#home">首页</a></li>
										                <li><a href="#about">关于</a></li>
												                <li><a href="#services">服务</a></li>
														                <li><a href="#contact">联系</a></li>
																            </ul>
																	            </nav>
																		        </header>

																			    <section id="home" class="hero">
																				            <h1>欢迎来到我的主页</h1>
																					            <p>Ruby 每日一码</p>
																						            <a href="https://www.ruby-lang.org/zh_cn/" class="btn">了解更多</a>
																							        </section>

																								    <section id="about" class="about">
																										            <p>"Ruby 每日一码" 是一个常见的学习 Ruby 编程语言的方式，通过每天练习一个小代码片段或解决一个问题来提升编程技能。以下是一个简单的 Ruby 代码示例，供你参考：

																											    ### 示例：计算斐波那契数列

																											    斐波那契数列是一个经典的编程问题，数列中的每个数字是前两个数字的和。例如：0, 1, 1, 2, 3, 5, 8, 13, ...

																											    ```ruby
																											    def fibonacci(n)
																											      if n <= 1
																											        n
																											      else
																											        fibonacci(n - 1) + fibonacci(n - 2)
																											      end
																											    end

																											    # 输出前10个斐波那契数
																											    (0..9).each do |i|
																											      puts fibonacci(i)
																											    end
																											    ```

																											    ### 解释：
																											    - `fibonacci` 函数是一个递归函数，用于计算第 `n` 个斐波那契数。
																											    - 如果 `n` 小于或等于 1，直接返回 `n`。
																											    - 否则，返回前两个斐波那契数的和。
																											    - `(0..9).each` 循环用于输出前 10 个斐波那契数。

																											    ### 输出：
																											    ```
																											    0
																											    1
																											    1
																											    2
																											    3
																											    5
																											    8
																											    13
																											    21
																											    34
																											    ```

																											    好的！既然你想要优化代码，我们可以对上面的斐波那契数列示例进行优化。原始的递归实现虽然简单，但在计算较大的斐波那契数时效率很低，因为它会重复计算很多次相同的值。

																											    我们可以通过 **动态规划** 或 **记忆化** 来优化代码，避免重复计算。

																											    ---

																											    ### 优化后的代码：使用记忆化（Memoization）

																											    ```ruby
																											    def fibonacci(n, memo = {})
																											      return n if n <= 1

																											      # 如果已经计算过，直接返回缓存的结果
																											      return memo[n] if memo.key?(n)

																											      # 计算并缓存结果
																											      memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo)
																											    end

																											    # 输出前10个斐波那契数
																											    (0..9).each do |i|
																											      puts fibonacci(i)
																											    end
																											    ```

																											    ---

																											    ### 优化点：
																											    1. **记忆化（Memoization）**：
																											       - 使用一个哈希表 `memo` 来缓存已经计算过的斐波那契数。
																											       - 每次计算前先检查是否已经缓存过结果，避免重复计算。

																											    2. **时间复杂度**：
																											       - 原始递归实现的时间复杂度是 \(O(2^n)\)，而优化后的时间复杂度降低到 \(O(n)\)，因为每个斐波那契数只需要计算一次。

																											    3. **空间复杂度**：
																											       - 空间复杂度为 \(O(n)\)，因为需要存储缓存的结果。

																											    ---

																											    ### 进一步优化：使用迭代

																											    递归虽然直观，但在 Ruby 中可能会因为栈深度限制而导致栈溢出。我们可以用迭代的方式进一步优化：

																											    ```ruby
																											    def fibonacci(n)
																											      return n if n <= 1

																											      a, b = 0, 1
																											      (2..n).each do |i|
																											        a, b = b, a + b
																											      end
																											      b
																											    end

																											    # 输出前10个斐波那契数
																											    (0..9).each do |i|
																											      puts fibonacci(i)
																											    end
																											    ```

																											    ---

																											    ### 优化点：
																											    1. **迭代代替递归**：
																											       - 使用两个变量 `a` 和 `b` 来保存前两个斐波那契数，通过循环计算下一个数。
																											       - 避免了递归调用栈的开销。

																											    2. **时间复杂度**：
																											       - 时间复杂度仍然是 \(O(n)\)，但空间复杂度降低到 \(O(1)\)，因为只使用了常数级别的额外空间。

																											    ---

																											    ### 输出：
																											    无论是哪种优化方式，输出结果都是：
																											    ```
																											    0
																											    1
																											    1
																											    2
																											    3
																											    5
																											    8
																											    13
																											    21
																											    34
																											    ```

																											    ---

																											    ### 总结：
																											    - **记忆化** 适合需要多次调用相同参数的场景。
																											    - **迭代** 适合单次计算且需要节省栈空间的场景。

																											    你可以根据实际需求选择适合的优化方式！如果你有其他问题或需要更多优化示例，欢迎告诉我！ 😊</p>
																											        </section>
r
																												    <footer>
																													            <p>&copy; 2023 简约风格主页. 保留所有权利。</p>
																														        </footer>
	</body>
</html>
