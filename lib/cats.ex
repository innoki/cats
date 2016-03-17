defmodule Cats do
  require Logger
  import Plug.Conn

  use Plug.Builder
  plug :fetch_query_params

  use Trot.Router

  @path_root "cats"

  # Return types

  @image_mime "image/gif"
  @image_data "R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7"
  @image_hdrs ["Content-Type": @image_mime]
  @image_rply {200, :base64.mime_decode(@image_data), @image_hdrs }

  @html_mime "text/html"
  @html_data "<html></html>"
  @html_hdrs ["Content-Type": @html_mime]
  @html_rply {200, @html_data}

  @mime_assoc %{
    "gif"  => @image_rply,
    "html" => @html_rply}

  @key_split ","
  @grp_split "|"

  # Routes

  get "/*query" do
    {keys, reply} = reply_type(query)
    Logger.info(print_keys(keys) <> @grp_split <> print_params(conn.query_params))
    reply
  end

  post "/*query" do
    {:ok, data, _conn} = read_body(conn, lenght: 80_000)
    {keys, _reply} = reply_type(query)
    Logger.info(
      print_keys(keys) <> @grp_split <>
      print_params(conn.query_params) <> @key_split <>
      print_body(data))
    @html_rply
  end

  # Private API

  defp reply_type([]), do: @html_rply
  defp reply_type([_ | _] = query) do
    [last | other_keys] = query |> Enum.reverse
    {last, reply} =
      with [file_type | tail] <- last |> String.split(".") |> Enum.reverse,
           reply              <- Map.get(@mime_assoc, file_type, @html_rply),
           key = if(tail == "", do: last, else: tail |> Enum.reverse |> Enum.join(".")),
           do: {key, reply}
    {[last | other_keys] |> Enum.reverse, reply}
  end

  defp print_keys(keys), do: keys |> Enum.join(@key_split)

  defp print_params(params) when is_map(params) or is_list(params),
  do: params |> Enum.map(&print_params/1) |> Enum.join(@key_split)

  defp print_params({key, value}), do: "#{key}=#{value}"

  defp print_body(raw_body), do: raw_body |> String.replace("\n", @key_split)
end
