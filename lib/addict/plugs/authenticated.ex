defmodule Addict.Plugs.Authenticated do
  @moduledoc """
  Authenticated plug can be used to filter actions for users that are
  authenticated.
  """
  import Plug.Conn

  def init(options) do
    options
  end


  @doc """
  Call represents the use of the plug itself.

  When called, it will assign `current_user` to `conn`, so it is
  possible to always retrieve the user via `conn.assigns.current_user`.

  If the current_user is already in assigns, the plug does nothing.
  This allows for creating tests without creating a session.

  In case the user is not logged in, it will redirect the request to
  the Application :addict :not_logged_in_url page. If none is defined, it will
  redirect to `/error`.
  """

  def call(conn, _) do
    conn = fetch_session(conn)
    session_current_user = get_session(conn, :current_user)

    cond do
      !is_nil(conn.assigns[:current_user]) -> conn
      !is_nil(session_current_user) ->
        assign(conn, :current_user, session_current_user)
      true ->
        not_logged_in_url = Addict.Configs.not_logged_in_url || "/login"
        conn |> Phoenix.Controller.redirect(to: not_logged_in_url) |> halt
    end
  end
end
