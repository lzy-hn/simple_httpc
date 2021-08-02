# SimpleHttpc

**基于 otp httpc 的 http 客户端**

## 特点
什么功能都没有

## 使用

在 mix.exs 中添加依赖：

```elixir
def deps do
  [
    {:simple_httpc, "~> 0.1.0"}
  ]
end
```

使用：
```elixir
defmodule Demo.Api do
  use SimpleHttpc

  def get_data() do
    get("http://baidu.com/")
  end
end
```

在 application.ex 添加 `Demo.Api.setup_profile()`
```elixir
defmodule Demo.Application do

# .. snip ..

  Demo.Api.setup_profile()  #

# .. snip ..

  Supervisor.start_link(children, opts)
end

```
