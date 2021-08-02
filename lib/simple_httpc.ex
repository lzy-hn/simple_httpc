defmodule SimpleHttpc do
  @moduledoc false

  defmacro __using__(opts) do
    quote do
      @prefix unquote(opts)[:prefix] || __MODULE__
      @pool_size unquote(opts)[:pool_size] || 8

      def profiles() do
        1..@pool_size
        |> Enum.map(&:"#{@prefix}#{&1}")
      end

      def setup_profile() do
        profiles()
        |> Enum.each(&:httpc_profile_sup.start_child(profile: &1))
      end

      def rand_profile() do
        @pool_size
        |> :rand.uniform()
        |> :lists.nth(profiles())
      end

      def post(
            url,
            body,
            headers \\ [],
            content_type \\ 'application/json',
            http_opts \\ [timeout: 15_000],
            opts \\ [body_format: :binary],
            profile \\ rand_profile()
          ) do
        :httpc.request(
          :post,
          {to_charlist(url), headers, content_type, body},
          http_opts,
          opts,
          profile
        )
      end

      def get(
            url,
            headers \\ [],
            http_opts \\ [timeout: 15_000],
            opts \\ [body_format: :binary],
            profile \\ rand_profile()
          ) do
        :httpc.request(
          :get,
          {to_charlist(url), headers},
          http_opts,
          opts,
          profile
        )
      end

      def status() do
        profiles()
        |> Enum.map(&profile_info(&1))
      end

      def profile_info(profile) do
        :httpc.info(profile)
      catch
        class, reason ->
          {class, reason}
      end

      @spec set_options(Keyword.t()) :: any()
      def set_options(opts) do
        profiles()
        |> Enum.each(&set_options(&1))
      end

      def set_options(opts, profile) do
        :httpc.set_options(opts, profile)
      catch
        class, reason ->
          {class, reason}
      end

      def restart() do
        profiles()
        |> Enum.each(&:httpc_profile_sup.restart_child(&1))
      end
    end
  end
end
