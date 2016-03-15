defmodule Cats do
  require Logger
  import Plug.Conn
  import String

  use Plug.Builder
  plug :fetch_query_params

  use Trot.Router

  @path_root "cats"

  @image_mime "image/gif"
  @image_data "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"
  @image_hdrs ["Content-Type": @image_mime]
  @image_rply {200, :base64.mime_decode(@image_data), @image_hdrs }

  @strip [".gif", ".html"]

  get "/:query" do
    Logger.info(strip_query(query) <> " " <> print_params(conn.query_params))
    @image_rply
  end

  defp strip_query(query) do
    to_strip = Enum.find(@strip, "", fn s -> query |> ends_with?(s) end)
    query |> replace_suffix(to_strip, "")
  end

  defp print_params(params) when is_map(params) or is_list(params),
  do: params |> Enum.map(&print_params/1) |> Enum.join(" ")

  defp print_params({key, value}), do: "#{key}=#{value}"
end
