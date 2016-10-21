defmodule LRTF.Router do
  use LRTF.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :secure do
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", LRTF do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/", LRTF do
    pipe_through :browser

    get "/login", PageController, :login
  end

  scope "/", LRTF do
    pipe_through [:browser, :secure]
    get "/", PageController, :index
    get "/*path", PageController, :index
  end

  defp put_user_token(conn, _) do
    if current_user = conn.private.plug_session["current_user"] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn |>
      Phoenix.Controller.redirect(to: "/login")
    end
  end
end
