defmodule CatsTest do
  use ExUnit.Case
  import Trot.TestHelper
  doctest Cats

  test "images" do
    conn = call(Cats, :get, "/cats/my/super_great/blogpost.gif?browser=moz&tz=0")
    assert conn.status == 200
    assert conn.resp_body != <<>>
  end

  test "html" do
    conn = call(Cats, :get, "/cats/2016/02/30/woopsie.html?did=you&spot=the&mistake=hell+yeah")
    assert conn.status == 200
    assert conn.resp_body == "<html></html>"
  end

  test "forms" do
    body = "abc=def\nhello=world+!"
    conn = call(Cats, :post, "/cats/hi/there/folks?ohai=lol", params = body)
    assert conn.status == 200
    assert conn.resp_body == "<html></html>"
  end
end
