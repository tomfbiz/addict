defmodule ExampleApp.PageControllerTest do
  use ExampleApp.ConnCase
  alias ExampleApp.User

  test "logged out GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Page available for logged in users only"
  end

  test "logged in GET /", %{conn: conn} do
    user = User.changeset(%User{}, %{name: "John",
                                     email: "john@example.com",
                                     encrypted_password: "encryped"})
           |> Repo.insert!
    Plug.Test.init_test_session(conn, %{current_user: user})
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "don't worry about user management"
  end
end
