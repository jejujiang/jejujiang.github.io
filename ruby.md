---
layout: default
title: Ruby
---
uby可以让你获得最新的Ruby版本或特定的版本。以下是详细步骤：

### 1. 安装依赖
首先，确保系统已安装必要的依赖包：

```bash
sudo apt update
sudo apt install -y git build-essential libssl-dev libreadline-dev zlib1g-dev
```

### 2. 下载Ruby源代码
访问[Ruby官方仓库](https://www.ruby-lang.org/en/downloads/)或[GitHub仓库](https://github.com/ruby/ruby)获取最新版本的源代码，或使用以下命令克隆：

```bash
git clone https://github.com/ruby/ruby.git
cd ruby
```

如果需要特定版本，切换到相应分支或标签：

```bash
git checkout v3_0_2  # 例如，切换到Ruby 3.0.2
```

### 3. 配置和编译
在Ruby源代码目录中，运行以下命令配置和编译：

```bash
./autogen.sh
./configure
make
```

### 4. 安装Ruby
编译完成后，安装Ruby：

```bash
sudo make install
```

### 5. 验证安装
安装完成后，验证Ruby版本：

```bash
ruby -v
```

### 6. 安装Bundler（可选）
如果需要，安装Bundler来管理Ruby依赖：

```bash
gem install bundler
```

### 7. 清理（可选）
安装完成后，可以删除源代码目录以释放空间：

```bash
cd ..
rm -rf ruby
```

通过这些步骤，你可以在Ubuntu中通过源代码安装Ruby。

---
---

执行./autogen.sh后，提示 ./autogen.sh: 17: exec: autoreconf: not found
---

这个错误表明系统中缺少 `autoreconf` 工具，它是 GNU Autotools 的一部分，用于生成配置脚本。要解决这个问题，你需要安装 `autoconf` 和 `automake` 工具。

### 解决方法

运行以下命令安装所需的工具：

```bash
sudo apt update
sudo apt install -y autoconf automake libtool
```

安装完成后，重新运行 `./autogen.sh`：

```bash
./autogen.sh
```

### 解释
- **autoconf**：用于生成 `configure` 脚本。
- **automake**：用于生成 `Makefile.in` 文件。
- **libtool**：用于管理库的编译和链接。

安装这些工具后，`autoreconf` 命令就可以正常使用了，`./autogen.sh` 也能顺利执行。

如果问题仍然存在，请确保你的系统环境变量配置正确，或者尝试手动运行以下命令来生成配置脚本：

```bash
autoreconf --install
```

然后再继续执行 `./configure` 和后续步骤。

---

make时提示，install libffi

如果在执行 `make` 时提示需要安装 `libffi`，这意味着 Ruby 的编译过程中依赖 `libffi` 库。`libffi` 是一个用于调用外部函数接口（FFI）的库，Ruby 的某些扩展（如 `ffi` gem）需要它。

### 解决方法

#### 1. 安装 `libffi` 开发包
在 Ubuntu 中，运行以下命令安装 `libffi` 的开发包：

```bash
sudo apt update
sudo apt install -y libffi-dev
```

#### 2. 重新配置和编译
安装完 `libffi-dev` 后，重新运行配置和编译命令：

```bash
./configure
make
```

#### 3. 继续安装
如果 `make` 成功完成，继续安装 Ruby：

```bash
sudo make install
```

#### 4. 验证安装
安装完成后，检查 Ruby 是否安装成功：

```bash
ruby -v
```

### 为什么需要 `libffi`？
`libffi` 是 Ruby 中某些扩展（如 `ffi` gem）的依赖库。它允许 Ruby 调用 C 函数，尤其是在需要与本地库交互时。如果不需要这些功能，可以在配置时禁用相关扩展，但通常建议安装 `libffi` 以确保完整的功能支持。

### 其他可能缺失的依赖
如果在编译过程中遇到其他类似的错误，提示缺少某些库（如 `libyaml`、`libgmp` 等），可以通过以下方式安装它们：

```bash
sudo apt install -y libyaml-dev libgmp-dev
```

安装完所有依赖后，重新运行 `./configure` 和 `make` 即可。

---
安装了 libffi-dev 还是提示 missing libffi

如果已经安装了 `libffi-dev`，但编译 Ruby 时仍然提示 `missing libffi`，可能是以下原因之一：

---

### 1. **`pkg-config` 未正确配置**
Ruby 的 `configure` 脚本使用 `pkg-config` 来查找 `libffi` 的路径。如果 `pkg-config` 没有正确配置，可能会导致找不到 `libffi`。

#### 解决方法：
确保 `pkg-config` 已安装并正确配置：

```bash
sudo apt install -y pkg-config
```

然后检查 `libffi` 是否可以被 `pkg-config` 找到：

```bash
pkg-config --libs libffi
```

如果输出类似以下内容，说明 `libffi` 已正确安装：

```
-lffi
```

如果没有输出或报错，可能需要手动设置 `PKG_CONFIG_PATH`：

```bash
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig
```

然后重新运行 `./configure`。

---

### 2. **`configure` 缓存问题**
如果之前运行过 `./configure`，它可能会缓存旧的配置结果，导致即使安装了 `libffi-dev`，仍然报错。

#### 解决方法：
清理缓存并重新配置：

```bash
make distclean
./configure
make
```

---

### 3. **`libffi` 的路径问题**
有时 `libffi` 的库文件或头文件可能不在默认的搜索路径中，导致 `configure` 找不到。

#### 解决方法：
手动指定 `libffi` 的路径。运行以下命令查找 `libffi` 的安装路径：

```bash
find /usr -name "libffi*"
```

找到路径后，将其传递给 `./configure`。例如：

```bash
./configure --with-libffi-include=/usr/include/x86_64-linux-gnu --with-libffi-lib=/usr/lib/x86_64-linux-gnu
```

---

### 4. **Ruby 配置选项问题**
某些 Ruby 版本可能需要显式启用 `libffi` 支持。

#### 解决方法：
在 `./configure` 中添加 `--enable-libffi` 选项：

```bash
./configure --enable-libffi
```

---

### 5. **系统环境问题**
如果系统中有多个版本的 `libffi`，可能会导致冲突。

#### 解决方法：
检查系统中是否安装了多个版本的 `libffi`：

```bash
dpkg -l | grep libffi
```

如果发现多个版本，尝试卸载冲突的版本：

```bash
sudo apt remove libffi7 libffi-dev
sudo apt install libffi-dev
```

---

### 6. **手动编译 `libffi`**
如果系统自带的 `libffi` 不兼容，可以尝试手动编译和安装最新版本的 `libffi`。

#### 步骤：
1. 下载 `libffi` 源码：

   ```bash
      wget https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz
         ```

	 2. 解压并编译：

	    ```bash
	       tar -xzf libffi-3.4.4.tar.gz
	          cd libffi-3.4.4
		     ./configure
		        make
			   sudo make install
			      ```

			      3. 更新动态库缓存：

			         ```bash
				    sudo ldconfig
				       ```

				       4. 重新运行 Ruby 的 `./configure` 和 `make`。

				       ---

				       ### 7. **使用 RVM 或 rbenv**
				       如果手动编译 Ruby 遇到太多问题，可以考虑使用版本管理工具（如 RVM 或 rbenv）来安装 Ruby。这些工具会自动处理依赖问题。

				       #### 使用 RVM：
				       ```bash
				       sudo apt install curl gpg
				       gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
				       \curl -sSL https://get.rvm.io | bash -s stable
				       source ~/.rvm/scripts/rvm
				       rvm install ruby
				       ```

				       #### 使用 rbenv：
				       ```bash
				       sudo apt install rbenv
				       rbenv init
				       rbenv install 3.2.2  # 替换为你需要的 Ruby 版本
				       rbenv global 3.2.2
				       ```

				       ---

				       ### 总结
				       如果以上方法仍然无法解决问题，请提供完整的错误日志，以便进一步分析。通常情况下，安装 `libffi-dev` 并正确配置 `pkg-config` 应该可以解决问题。如果问题复杂，建议使用 RVM 或 rbenv 来简化 Ruby 的安装过程。

---
---
使用 gem install 时，提示”Default to user installation because default installation directory (/usr/local/lib/ruby/gems/3.4.0) is not writable.”。

这个提示表明你尝试使用 `gem install` 安装 gem 包时，默认的系统级安装目录 (`/usr/local/lib/ruby/gems/3.4.0`) 不可写（通常是因为没有 `sudo` 权限）。因此，RubyGems 默认将 gem 安装到用户目录中（`~/.gem`）。

这是正常行为，尤其是当你没有系统管理员权限时。以下是几种解决方法：

---

### 1. **使用用户目录安装（推荐）**
这是最简单的解决方案。RubyGems 会将 gem 安装到你的用户目录中（例如 `~/.gem`），不会影响系统全局环境。

只需按照提示继续安装即可：

```bash
gem install <gem-name>
```

安装后，gem 会被安装到 `~/.gem` 目录中，Ruby 也可以正常加载这些 gem。

---

### 2. **配置 GEM_HOME 和 GEM_PATH**
如果你希望将用户安装的 gem 放到特定目录，可以设置 `GEM_HOME` 和 `GEM_PATH` 环境变量。

例如，将 gem 安装到 `~/.ruby/gems`：

```bash
# 创建目录
mkdir -p ~/.ruby/gems

# 设置环境变量
export GEM_HOME=~/.ruby/gems
export GEM_PATH=~/.ruby/gems

# 将 GEM_HOME 的 bin 目录添加到 PATH
export PATH=~/.ruby/gems/bin:$PATH

# 安装 gem
gem install <gem-name>
```

为了让这些设置永久生效，可以将以下内容添加到 `~/.bashrc` 或 `~/.zshrc` 文件中：

```bash
export GEM_HOME=~/.ruby/gems
export GEM_PATH=~/.ruby/gems
export PATH=~/.ruby/gems/bin:$PATH
```

然后运行 `source ~/.bashrc` 或 `source ~/.zshrc` 使配置生效。

---

### 3. **使用 `--user-install` 选项**
如果你不想设置环境变量，可以直接使用 `--user-install` 选项将 gem 安装到用户目录：

```bash
gem install <gem-name> --user-install
```

安装后，gem 会被安装到 `~/.gem/ruby/X.Y.Z` 目录中（`X.Y.Z` 是 Ruby 版本号）。

---

### 4. **使用 `sudo` 安装到系统目录（不推荐）**
如果你有管理员权限，并且希望将 gem 安装到系统目录，可以使用 `sudo`：

```bash
sudo gem install <gem-name>
```

**注意：** 这种方法不推荐，因为它可能会干扰系统的 Ruby 环境，尤其是在使用系统自带的 Ruby 时。

---

### 5. **使用 RVM 或 rbenv 管理 Ruby 环境**
如果你经常需要安装 gem，建议使用 RVM 或 rbenv 来管理 Ruby 环境。这些工具会将 Ruby 和 gem 安装到用户目录中，避免权限问题。

#### 使用 RVM：
```bash
# 安装 RVM
\curl -sSL https://get.rvm.io | bash -s stable

# 加载 RVM
source ~/.rvm/scripts/rvm

# 安装 Ruby
rvm install 3.2.2

# 设置默认 Ruby 版本
rvm use 3.2.2 --default

# 安装 gem
gem install <gem-name>
```

#### 使用 rbenv：
```bash
# 安装 rbenv
sudo apt install rbenv

# 初始化 rbenv
rbenv init

# 安装 Ruby
rbenv install 3.2.2

# 设置全局 Ruby 版本
rbenv global 3.2.2

# 安装 gem
gem install <gem-name>
```

---

### 6. **检查 Ruby 安装目录的权限**
如果你确实需要将 gem 安装到系统目录，可以检查并修改 Ruby 安装目录的权限：

```bash
# 检查目录权限
ls -ld /usr/local/lib/ruby/gems/3.4.0

# 修改权限（谨慎操作）
sudo chown -R $USER /usr/local/lib/ruby/gems/3.4.0
```

**注意：** 修改系统目录的权限可能会导致安全问题，因此不推荐。

---

### 总结
- 如果你没有管理员权限，推荐使用用户目录安装（方法 1 或方法 2）。
- 如果你有管理员权限且需要全局安装，可以使用 `sudo`（方法 4），但需谨慎。
- 对于长期开发，建议使用 RVM 或 rbenv 管理 Ruby 环境（方法 5）。

---
---
源代码安装Ruby的GEM_HOME和GEM_PATH的值是什么？

通过源代码安装 Ruby 时，`GEM_HOME` 和 `GEM_PATH` 的值取决于你的安装配置和环境变量设置。以下是详细说明：

---

### 1. **默认的 `GEM_HOME` 和 `GEM_PATH`**
如果你通过源代码安装 Ruby 并且没有显式设置 `GEM_HOME` 和 `GEM_PATH`，它们的默认值如下：

#### **`GEM_HOME`**
- 如果你使用 `sudo make install` 安装 Ruby，`GEM_HOME` 通常是：
  ```
    /usr/local/lib/ruby/gems/X.Y.Z
      ```
        其中 `X.Y.Z` 是 Ruby 的版本号（例如 `3.2.2`）。

	- 如果你在用户目录下安装 Ruby（例如 `./configure --prefix=$HOME/ruby`），`GEM_HOME` 通常是：
	  ```
	    ~/ruby/lib/ruby/gems/X.Y.Z
	      ```

	      #### **`GEM_PATH`**
	      - 如果没有设置 `GEM_PATH`，它的值通常与 `GEM_HOME` 相同。
	      - 如果系统中存在多个 Ruby 版本或 gem 目录，`GEM_PATH` 可能包含多个路径，例如：
	        ```
		  /usr/local/lib/ruby/gems/X.Y.Z:/usr/lib/ruby/gems/X.Y.Z
		    ```

		    ---

		    ### 2. **查看当前的 `GEM_HOME` 和 `GEM_PATH`**
		    你可以通过以下命令查看当前的 `GEM_HOME` 和 `GEM_PATH`：

		    ```bash
		    ruby -e 'puts Gem.path'
		    ```

		    输出示例：
		    ```
		    /home/username/.gem/ruby/3.2.0
		    /usr/local/lib/ruby/gems/3.2.0
		    ```

		    - 第一个路径通常是用户目录下的 gem 路径（`~/.gem/ruby/X.Y.Z`）。
		    - 第二个路径是系统级的 gem 路径（`/usr/local/lib/ruby/gems/X.Y.Z`）。

		    ---

		    ### 3. **设置 `GEM_HOME` 和 `GEM_PATH`**
		    如果你希望自定义 `GEM_HOME` 和 `GEM_PATH`，可以通过以下方式设置：

		    #### **临时设置**
		    在终端中运行以下命令：

		    ```bash
		    export GEM_HOME=~/.gem/ruby/3.2.0
		    export GEM_PATH=~/.gem/ruby/3.2.0:/usr/local/lib/ruby/gems/3.2.0
		    ```

		    #### **永久设置**
		    将以下内容添加到 `~/.bashrc` 或 `~/.zshrc` 文件中：

		    ```bash
		    export GEM_HOME=~/.gem/ruby/3.2.0
		    export GEM_PATH=~/.gem/ruby/3.2.0:/usr/local/lib/ruby/gems/3.2.0
		    export PATH=$GEM_HOME/bin:$PATH
		    ```

		    然后运行以下命令使配置生效：

		    ```bash
		    source ~/.bashrc  # 或者 source ~/.zshrc
		    ```

		    ---

		    ### 4. **使用 `gem env` 查看 RubyGems 环境**
		    运行以下命令可以查看完整的 RubyGems 环境信息：

		    ```bash
		    gem env
		    ```

		    输出示例：
		    ```
		    RubyGems Environment:
		      - RUBYGEMS VERSION: 3.4.10
		        - RUBY VERSION: 3.2.2 (2023-03-30 patchlevel 0) [x86_64-linux]
			  - INSTALLATION DIRECTORY: /usr/local/lib/ruby/gems/3.2.0
			    - USER INSTALLATION DIRECTORY: /home/username/.gem/ruby/3.2.0
			      - RUBY EXECUTABLE: /usr/local/bin/ruby
			        - GEM PATHS:
				     - /usr/local/lib/ruby/gems/3.2.0
				          - /home/username/.gem/ruby/3.2.0
					    - GEM CONFIGURATION:
					         - :update_sources => true
						      - :verbose => true
						           - :backtrace => false
							        - :bulk_threshold => 1000
								  - REMOTE SOURCES:
								       - https://rubygems.org/
								         - SHELL PATH:
									      - /usr/local/bin
									           - /usr/bin
										        - /bin
											```

											- **`INSTALLATION DIRECTORY`**：系统级的 gem 安装目录（`GEM_HOME` 的一部分）。
											- **`USER INSTALLATION DIRECTORY`**：用户级的 gem 安装目录（`~/.gem/ruby/X.Y.Z`）。

											---

											### 5. **总结**
											- 默认情况下，`GEM_HOME` 和 `GEM_PATH` 的值取决于 Ruby 的安装方式和环境配置。
											- 你可以通过 `gem env` 或 `ruby -e 'puts Gem.path'` 查看当前的值。
											- 如果需要自定义，可以通过设置 `GEM_HOME` 和 `GEM_PATH` 环境变量来实现。

											如果你希望将 gem 安装到用户目录（避免权限问题），建议设置 `GEM_HOME` 为 `~/.gem/ruby/X.Y.Z`，并将 `~/.gem/ruby/X.Y.Z/bin` 添加到 `PATH` 中。


---
---
源代码安装的Ruby，如何卸载

通过源代码安装的 Ruby 可以通过以下步骤完全卸载。卸载过程包括删除 Ruby 的安装目录、相关的可执行文件以及 gem 安装的库。

---

### 1. **确定 Ruby 的安装路径**
在卸载之前，首先需要确定 Ruby 的安装路径。可以通过以下命令查看：

```bash
which ruby
```

输出示例：
```
/usr/local/bin/ruby
```

然后查看 Ruby 的安装前缀（prefix）：

```bash
ruby -e 'puts RbConfig::CONFIG["prefix"]'
```

输出示例：
```
/usr/local
```

这意味着 Ruby 安装在 `/usr/local` 目录下。

---

### 2. **删除 Ruby 的安装目录**
根据上一步的输出，删除 Ruby 的安装目录。例如，如果 Ruby 安装在 `/usr/local`，可以运行以下命令：

```bash
sudo rm -rf /usr/local/bin/ruby
sudo rm -rf /usr/local/bin/gem
sudo rm -rf /usr/local/bin/irb
sudo rm -rf /usr/local/bin/rake
sudo rm -rf /usr/local/bin/bundle
sudo rm -rf /usr/local/lib/ruby
sudo rm -rf /usr/local/include/ruby
sudo rm -rf /usr/local/share/ri
```

如果你将 Ruby 安装到自定义目录（例如 `./configure --prefix=$HOME/ruby`），则删除该目录：

```bash
rm -rf ~/ruby
```

---

### 3. **删除用户安装的 gem**
RubyGems 会将用户安装的 gem 存储在 `~/.gem` 目录中。如果你希望删除这些 gem，可以运行：

```bash
rm -rf ~/.gem
```

---

### 4. **清理环境变量**
如果你在 `~/.bashrc`、`~/.zshrc` 或其他配置文件中设置了与 Ruby 相关的环境变量（如 `PATH`、`GEM_HOME`、`GEM_PATH` 等），需要手动清理。

打开配置文件：

```bash
nano ~/.bashrc  # 或者 ~/.zshrc
```

删除或注释掉与 Ruby 相关的行，例如：

```bash
# export PATH=$HOME/ruby/bin:$PATH
# export GEM_HOME=$HOME/.gem/ruby/X.Y.Z
# export GEM_PATH=$HOME/.gem/ruby/X.Y.Z
```

保存文件后，运行以下命令使更改生效：

```bash
source ~/.bashrc  # 或者 source ~/.zshrc
```

---

### 5. **验证卸载**
运行以下命令验证 Ruby 是否已完全卸载：

```bash
which ruby
ruby -v
gem -v
```

如果输出为空或提示命令未找到，说明 Ruby 已成功卸载。

---

### 6. **（可选）使用 RVM 或 rbenv 重新安装 Ruby**
如果你希望重新安装 Ruby，推荐使用版本管理工具（如 RVM 或 rbenv），它们可以更方便地管理 Ruby 的安装和卸载。

#### 使用 RVM 安装 Ruby：
```bash
# 安装 RVM
\curl -sSL https://get.rvm.io | bash -s stable

# 加载 RVM
source ~/.rvm/scripts/rvm

# 安装 Ruby
rvm install 3.2.2

# 设置默认 Ruby 版本
rvm use 3.2.2 --default
```

#### 使用 rbenv 安装 Ruby：
```bash
# 安装 rbenv
sudo apt install rbenv

# 初始化 rbenv
rbenv init

# 安装 Ruby
rbenv install 3.2.2

# 设置全局 Ruby 版本
rbenv global 3.2.2
```

---

### 总结
通过以上步骤，你可以完全卸载通过源代码安装的 Ruby。如果你需要重新安装 Ruby，建议使用 RVM 或 rbenv 来管理 Ruby 版本，以避免手动管理带来的复杂性。
