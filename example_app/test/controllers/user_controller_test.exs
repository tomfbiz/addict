defmodule ExampleApp.UserControllerTest do
  use ExampleApp.ConnCase

  alias ExampleApp.User
  @valid_attrs %{email: "some content", encrypted_password: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_management_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

 
  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, user_management_path(conn, :delete, user)
    assert redirected_to(conn) == user_management_path(conn, :index)
    refute Repo.get(User, user.id)
  end
end
